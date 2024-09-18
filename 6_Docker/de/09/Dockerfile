# Use the Fluentd base image
FROM fluent/fluentd:v1.14-1

# Copy your Fluentd configuration file into the container
COPY fluent.conf /fluentd/etc/fluent.conf

# Expose the Fluentd port for incoming logs
EXPOSE 24224


# ____________________________________
# docker run -d \
#   --name fluentd \
#   -v $(pwd)/fluentd.conf:/fluentd/etc/fluentd.conf \
#   -p 24224:24224 \
#   fluent/fluentd:edge-debian
# _________________________________________________