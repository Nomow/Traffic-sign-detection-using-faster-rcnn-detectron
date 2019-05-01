function output_frame = ReadVideoFrame(video,frame_number)
    info=get(video);
    video.CurrentTime=(frame_number-1)/info.FrameRate;
    output_frame=readFrame(video);
end


