Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C70B915FD95
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2020 09:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726504AbgBOImC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 15 Feb 2020 03:42:02 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56777 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgBOImB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 15 Feb 2020 03:42:01 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j2t1H-0005DH-69; Sat, 15 Feb 2020 09:41:47 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D12C01C2039;
        Sat, 15 Feb 2020 09:41:46 +0100 (CET)
Date:   Sat, 15 Feb 2020 08:41:46 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools include UAPI: Sync sound/asound.h copy
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linaro.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158175610659.13786.3756288602319875882.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     8c65582f82ee736b63b3c0cd9c7c5b4572f1f4d6
Gitweb:        https://git.kernel.org/tip/8c65582f82ee736b63b3c0cd9c7c5b4572f1f4d6
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 12 Feb 2020 11:04:23 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 12 Feb 2020 11:04:23 -03:00

tools include UAPI: Sync sound/asound.h copy

Picking the changes from:

  46b770f720bd ("ALSA: uapi: Fix sparse warning")
  a103a3989993 ("ALSA: control: Fix incompatible protocol error")
  bd3eb4e87eb3 ("ALSA: ctl: bump protocol version up to v2.1.0")
  ff16351e3f30 ("ALSA: ctl: remove dimen member from elem_info structure")
  542283566679 ("ALSA: ctl: remove unused macro for timestamping of elem_value")
  7fd7d6c50451 ("ALSA: uapi: Fix typos and header inclusion in asound.h")
  1cfaef961703 ("ALSA: bump uapi version numbers")
  80fe7430c708 ("ALSA: add new 32-bit layout for snd_pcm_mmap_status/control")
  07094ae6f952 ("ALSA: Avoid using timespec for struct snd_timer_tread")
  d9e5582c4bb2 ("ALSA: Avoid using timespec for struct snd_rawmidi_status")
  3ddee7f88aaf ("ALSA: Avoid using timespec for struct snd_pcm_status")
  a4e7dd35b9da ("ALSA: Avoid using timespec for struct snd_ctl_elem_value")
  a07804cc7472 ("ALSA: Avoid using timespec for struct snd_timer_status")

Which entails no changes in the tooling side.

To silence this perf tools build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/sound/asound.h' differs from latest version at 'include/uapi/sound/asound.h'
  diff -u tools/include/uapi/sound/asound.h include/uapi/sound/asound.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Baolin Wang <baolin.wang@linaro.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ranjani Sridharan <ranjani.sridharan@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/sound/asound.h | 155 ++++++++++++++++++++++++-----
 1 file changed, 132 insertions(+), 23 deletions(-)

diff --git a/tools/include/uapi/sound/asound.h b/tools/include/uapi/sound/asound.h
index df1153c..535a722 100644
--- a/tools/include/uapi/sound/asound.h
+++ b/tools/include/uapi/sound/asound.h
@@ -26,7 +26,9 @@
 
 #if defined(__KERNEL__) || defined(__linux__)
 #include <linux/types.h>
+#include <asm/byteorder.h>
 #else
+#include <endian.h>
 #include <sys/ioctl.h>
 #endif
 
@@ -154,7 +156,7 @@ struct snd_hwdep_dsp_image {
  *                                                                           *
  *****************************************************************************/
 
-#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 14)
+#define SNDRV_PCM_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 15)
 
 typedef unsigned long snd_pcm_uframes_t;
 typedef signed long snd_pcm_sframes_t;
@@ -301,7 +303,9 @@ typedef int __bitwise snd_pcm_subformat_t;
 #define SNDRV_PCM_INFO_DRAIN_TRIGGER	0x40000000		/* internal kernel flag - trigger in drain */
 #define SNDRV_PCM_INFO_FIFO_IN_FRAMES	0x80000000	/* internal kernel flag - FIFO size is in frames */
 
-
+#if (__BITS_PER_LONG == 32 && defined(__USE_TIME_BITS64)) || defined __KERNEL__
+#define __SND_STRUCT_TIME64
+#endif
 
 typedef int __bitwise snd_pcm_state_t;
 #define	SNDRV_PCM_STATE_OPEN		((__force snd_pcm_state_t) 0) /* stream is open */
@@ -317,8 +321,17 @@ typedef int __bitwise snd_pcm_state_t;
 
 enum {
 	SNDRV_PCM_MMAP_OFFSET_DATA = 0x00000000,
-	SNDRV_PCM_MMAP_OFFSET_STATUS = 0x80000000,
-	SNDRV_PCM_MMAP_OFFSET_CONTROL = 0x81000000,
+	SNDRV_PCM_MMAP_OFFSET_STATUS_OLD = 0x80000000,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL_OLD = 0x81000000,
+	SNDRV_PCM_MMAP_OFFSET_STATUS_NEW = 0x82000000,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW = 0x83000000,
+#ifdef __SND_STRUCT_TIME64
+	SNDRV_PCM_MMAP_OFFSET_STATUS = SNDRV_PCM_MMAP_OFFSET_STATUS_NEW,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL = SNDRV_PCM_MMAP_OFFSET_CONTROL_NEW,
+#else
+	SNDRV_PCM_MMAP_OFFSET_STATUS = SNDRV_PCM_MMAP_OFFSET_STATUS_OLD,
+	SNDRV_PCM_MMAP_OFFSET_CONTROL = SNDRV_PCM_MMAP_OFFSET_CONTROL_OLD,
+#endif
 };
 
 union snd_pcm_sync_id {
@@ -456,8 +469,13 @@ enum {
 	SNDRV_PCM_AUDIO_TSTAMP_TYPE_LAST = SNDRV_PCM_AUDIO_TSTAMP_TYPE_LINK_SYNCHRONIZED
 };
 
+#ifndef __KERNEL__
+/* explicit padding avoids incompatibility between i386 and x86-64 */
+typedef struct { unsigned char pad[sizeof(time_t) - sizeof(int)]; } __time_pad;
+
 struct snd_pcm_status {
 	snd_pcm_state_t state;		/* stream state */
+	__time_pad pad1;		/* align to timespec */
 	struct timespec trigger_tstamp;	/* time when stream was started/stopped/paused */
 	struct timespec tstamp;		/* reference timestamp */
 	snd_pcm_uframes_t appl_ptr;	/* appl ptr */
@@ -473,17 +491,48 @@ struct snd_pcm_status {
 	__u32 audio_tstamp_accuracy;	/* in ns units, only valid if indicated in audio_tstamp_data */
 	unsigned char reserved[52-2*sizeof(struct timespec)]; /* must be filled with zero */
 };
+#endif
+
+/*
+ * For mmap operations, we need the 64-bit layout, both for compat mode,
+ * and for y2038 compatibility. For 64-bit applications, the two definitions
+ * are identical, so we keep the traditional version.
+ */
+#ifdef __SND_STRUCT_TIME64
+#define __snd_pcm_mmap_status64		snd_pcm_mmap_status
+#define __snd_pcm_mmap_control64	snd_pcm_mmap_control
+#define __snd_pcm_sync_ptr64		snd_pcm_sync_ptr
+#ifdef __KERNEL__
+#define __snd_timespec64		__kernel_timespec
+#else
+#define __snd_timespec64		timespec
+#endif
+struct __snd_timespec {
+	__s32 tv_sec;
+	__s32 tv_nsec;
+};
+#else
+#define __snd_pcm_mmap_status		snd_pcm_mmap_status
+#define __snd_pcm_mmap_control		snd_pcm_mmap_control
+#define __snd_pcm_sync_ptr		snd_pcm_sync_ptr
+#define __snd_timespec			timespec
+struct __snd_timespec64 {
+	__s64 tv_sec;
+	__s64 tv_nsec;
+};
 
-struct snd_pcm_mmap_status {
+#endif
+
+struct __snd_pcm_mmap_status {
 	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
 	int pad1;			/* Needed for 64 bit alignment */
 	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
-	struct timespec tstamp;		/* Timestamp */
+	struct __snd_timespec tstamp;	/* Timestamp */
 	snd_pcm_state_t suspended_state; /* RO: suspended stream state */
-	struct timespec audio_tstamp;	/* from sample counter or wall clock */
+	struct __snd_timespec audio_tstamp; /* from sample counter or wall clock */
 };
 
-struct snd_pcm_mmap_control {
+struct __snd_pcm_mmap_control {
 	snd_pcm_uframes_t appl_ptr;	/* RW: appl ptr (0...boundary-1) */
 	snd_pcm_uframes_t avail_min;	/* RW: min available frames for wakeup */
 };
@@ -492,14 +541,59 @@ struct snd_pcm_mmap_control {
 #define SNDRV_PCM_SYNC_PTR_APPL		(1<<1)	/* get appl_ptr from driver (r/w op) */
 #define SNDRV_PCM_SYNC_PTR_AVAIL_MIN	(1<<2)	/* get avail_min from driver */
 
-struct snd_pcm_sync_ptr {
+struct __snd_pcm_sync_ptr {
 	unsigned int flags;
 	union {
-		struct snd_pcm_mmap_status status;
+		struct __snd_pcm_mmap_status status;
+		unsigned char reserved[64];
+	} s;
+	union {
+		struct __snd_pcm_mmap_control control;
+		unsigned char reserved[64];
+	} c;
+};
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __BIG_ENDIAN : defined(__BIG_ENDIAN)
+typedef char __pad_before_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
+typedef char __pad_after_uframe[0];
+#endif
+
+#if defined(__BYTE_ORDER) ? __BYTE_ORDER == __LITTLE_ENDIAN : defined(__LITTLE_ENDIAN)
+typedef char __pad_before_uframe[0];
+typedef char __pad_after_uframe[sizeof(__u64) - sizeof(snd_pcm_uframes_t)];
+#endif
+
+struct __snd_pcm_mmap_status64 {
+	snd_pcm_state_t state;		/* RO: state - SNDRV_PCM_STATE_XXXX */
+	__u32 pad1;			/* Needed for 64 bit alignment */
+	__pad_before_uframe __pad1;
+	snd_pcm_uframes_t hw_ptr;	/* RO: hw ptr (0...boundary-1) */
+	__pad_after_uframe __pad2;
+	struct __snd_timespec64 tstamp;	/* Timestamp */
+	snd_pcm_state_t suspended_state;/* RO: suspended stream state */
+	__u32 pad3;			/* Needed for 64 bit alignment */
+	struct __snd_timespec64 audio_tstamp; /* sample counter or wall clock */
+};
+
+struct __snd_pcm_mmap_control64 {
+	__pad_before_uframe __pad1;
+	snd_pcm_uframes_t appl_ptr;	 /* RW: appl ptr (0...boundary-1) */
+	__pad_before_uframe __pad2;
+
+	__pad_before_uframe __pad3;
+	snd_pcm_uframes_t  avail_min;	 /* RW: min available frames for wakeup */
+	__pad_after_uframe __pad4;
+};
+
+struct __snd_pcm_sync_ptr64 {
+	__u32 flags;
+	__u32 pad1;
+	union {
+		struct __snd_pcm_mmap_status64 status;
 		unsigned char reserved[64];
 	} s;
 	union {
-		struct snd_pcm_mmap_control control;
+		struct __snd_pcm_mmap_control64 control;
 		unsigned char reserved[64];
 	} c;
 };
@@ -584,6 +678,8 @@ enum {
 #define SNDRV_PCM_IOCTL_STATUS		_IOR('A', 0x20, struct snd_pcm_status)
 #define SNDRV_PCM_IOCTL_DELAY		_IOR('A', 0x21, snd_pcm_sframes_t)
 #define SNDRV_PCM_IOCTL_HWSYNC		_IO('A', 0x22)
+#define __SNDRV_PCM_IOCTL_SYNC_PTR	_IOWR('A', 0x23, struct __snd_pcm_sync_ptr)
+#define __SNDRV_PCM_IOCTL_SYNC_PTR64	_IOWR('A', 0x23, struct __snd_pcm_sync_ptr64)
 #define SNDRV_PCM_IOCTL_SYNC_PTR	_IOWR('A', 0x23, struct snd_pcm_sync_ptr)
 #define SNDRV_PCM_IOCTL_STATUS_EXT	_IOWR('A', 0x24, struct snd_pcm_status)
 #define SNDRV_PCM_IOCTL_CHANNEL_INFO	_IOR('A', 0x32, struct snd_pcm_channel_info)
@@ -614,7 +710,7 @@ enum {
  *  Raw MIDI section - /dev/snd/midi??
  */
 
-#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 0)
+#define SNDRV_RAWMIDI_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 1)
 
 enum {
 	SNDRV_RAWMIDI_STREAM_OUTPUT = 0,
@@ -648,13 +744,16 @@ struct snd_rawmidi_params {
 	unsigned char reserved[16];	/* reserved for future use */
 };
 
+#ifndef __KERNEL__
 struct snd_rawmidi_status {
 	int stream;
+	__time_pad pad1;
 	struct timespec tstamp;		/* Timestamp */
 	size_t avail;			/* available bytes */
 	size_t xruns;			/* count of overruns since last status (in bytes) */
 	unsigned char reserved[16];	/* reserved for future use */
 };
+#endif
 
 #define SNDRV_RAWMIDI_IOCTL_PVERSION	_IOR('W', 0x00, int)
 #define SNDRV_RAWMIDI_IOCTL_INFO	_IOR('W', 0x01, struct snd_rawmidi_info)
@@ -667,7 +766,7 @@ struct snd_rawmidi_status {
  *  Timer section - /dev/snd/timer
  */
 
-#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 6)
+#define SNDRV_TIMER_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 7)
 
 enum {
 	SNDRV_TIMER_CLASS_NONE = -1,
@@ -761,6 +860,7 @@ struct snd_timer_params {
 	unsigned char reserved[60];	/* reserved */
 };
 
+#ifndef __KERNEL__
 struct snd_timer_status {
 	struct timespec tstamp;		/* Timestamp - last update */
 	unsigned int resolution;	/* current period resolution in ns */
@@ -769,10 +869,11 @@ struct snd_timer_status {
 	unsigned int queue;		/* used queue size */
 	unsigned char reserved[64];	/* reserved */
 };
+#endif
 
 #define SNDRV_TIMER_IOCTL_PVERSION	_IOR('T', 0x00, int)
 #define SNDRV_TIMER_IOCTL_NEXT_DEVICE	_IOWR('T', 0x01, struct snd_timer_id)
-#define SNDRV_TIMER_IOCTL_TREAD		_IOW('T', 0x02, int)
+#define SNDRV_TIMER_IOCTL_TREAD_OLD	_IOW('T', 0x02, int)
 #define SNDRV_TIMER_IOCTL_GINFO		_IOWR('T', 0x03, struct snd_timer_ginfo)
 #define SNDRV_TIMER_IOCTL_GPARAMS	_IOW('T', 0x04, struct snd_timer_gparams)
 #define SNDRV_TIMER_IOCTL_GSTATUS	_IOWR('T', 0x05, struct snd_timer_gstatus)
@@ -785,6 +886,15 @@ struct snd_timer_status {
 #define SNDRV_TIMER_IOCTL_STOP		_IO('T', 0xa1)
 #define SNDRV_TIMER_IOCTL_CONTINUE	_IO('T', 0xa2)
 #define SNDRV_TIMER_IOCTL_PAUSE		_IO('T', 0xa3)
+#define SNDRV_TIMER_IOCTL_TREAD64	_IOW('T', 0xa4, int)
+
+#if __BITS_PER_LONG == 64
+#define SNDRV_TIMER_IOCTL_TREAD SNDRV_TIMER_IOCTL_TREAD_OLD
+#else
+#define SNDRV_TIMER_IOCTL_TREAD ((sizeof(__kernel_long_t) >= sizeof(time_t)) ? \
+				 SNDRV_TIMER_IOCTL_TREAD_OLD : \
+				 SNDRV_TIMER_IOCTL_TREAD64)
+#endif
 
 struct snd_timer_read {
 	unsigned int resolution;
@@ -810,11 +920,15 @@ enum {
 	SNDRV_TIMER_EVENT_MRESUME = SNDRV_TIMER_EVENT_RESUME + 10,
 };
 
+#ifndef __KERNEL__
 struct snd_timer_tread {
 	int event;
+	__time_pad pad1;
 	struct timespec tstamp;
 	unsigned int val;
+	__time_pad pad2;
 };
+#endif
 
 /****************************************************************************
  *                                                                          *
@@ -822,7 +936,7 @@ struct snd_timer_tread {
  *                                                                          *
  ****************************************************************************/
 
-#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 7)
+#define SNDRV_CTL_VERSION		SNDRV_PROTOCOL_VERSION(2, 0, 8)
 
 struct snd_ctl_card_info {
 	int card;			/* card number */
@@ -860,7 +974,7 @@ typedef int __bitwise snd_ctl_elem_iface_t;
 #define SNDRV_CTL_ELEM_ACCESS_WRITE		(1<<1)
 #define SNDRV_CTL_ELEM_ACCESS_READWRITE		(SNDRV_CTL_ELEM_ACCESS_READ|SNDRV_CTL_ELEM_ACCESS_WRITE)
 #define SNDRV_CTL_ELEM_ACCESS_VOLATILE		(1<<2)	/* control value may be changed without a notification */
-#define SNDRV_CTL_ELEM_ACCESS_TIMESTAMP		(1<<3)	/* when was control changed */
+// (1 << 3) is unused.
 #define SNDRV_CTL_ELEM_ACCESS_TLV_READ		(1<<4)	/* TLV read is possible */
 #define SNDRV_CTL_ELEM_ACCESS_TLV_WRITE		(1<<5)	/* TLV write is possible */
 #define SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE	(SNDRV_CTL_ELEM_ACCESS_TLV_READ|SNDRV_CTL_ELEM_ACCESS_TLV_WRITE)
@@ -926,11 +1040,7 @@ struct snd_ctl_elem_info {
 		} enumerated;
 		unsigned char reserved[128];
 	} value;
-	union {
-		unsigned short d[4];		/* dimensions */
-		unsigned short *d_ptr;		/* indirect - obsoleted */
-	} dimen;
-	unsigned char reserved[64-4*sizeof(unsigned short)];
+	unsigned char reserved[64];
 };
 
 struct snd_ctl_elem_value {
@@ -955,8 +1065,7 @@ struct snd_ctl_elem_value {
 		} bytes;
 		struct snd_aes_iec958 iec958;
 	} value;		/* RO */
-	struct timespec tstamp;
-	unsigned char reserved[128-sizeof(struct timespec)];
+	unsigned char reserved[128];
 };
 
 struct snd_ctl_tlv {
