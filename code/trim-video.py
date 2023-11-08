import os
from shlex import quote

# Trim videos into 2-min long
# Use the following bash code to get ffmpeg
# export PATH=/software/ffmpeg:/software/ffmpeg/bin:$PATH


video_dir = "my-video-directory"
truncated_video_dir = "my-trimmed-video-directory"

def main():
    errors_cut =[]
    for filename in tqdm(os.listdir(video_dir)[:]):
        try:
            video_id = os.path.basename(filename).split('.')[0]
            output = video_id +'_c.mp4'
            command = "ffmpeg -accurate_seek -ss 00:00:00 -i " + os.path.join(video_dir, filename) + " -to 00:02:10  -c:v copy -c:a copy " + os.path.join(truncated_video_dir, output)
            #print(command)
            os.system(command)
        except:
            errors_cut.append(filename)
            pass

if __name__ == "__main__":
    main()