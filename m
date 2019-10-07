Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79534CE606
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Oct 2019 16:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727745AbfJGOvq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Oct 2019 10:51:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44331 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbfJGOtb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:31 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKB-00062r-OJ; Mon, 07 Oct 2019 16:49:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1B0A51C0DD1;
        Mon,  7 Oct 2019 16:49:17 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:17 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] tools headers uapi: Sync linux/fs.h with the
 kernel sources
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Eric Biggers <ebiggers@google.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-44g48exl9br9ba0t64chqb4i@git.kernel.org>
References: <tip-44g48exl9br9ba0t64chqb4i@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157045975703.9978.16235634906115049663.tip-bot2@tip-bot2>
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

Commit-ID:     0ae4061223a3d097222cbec6599370e54db17731
Gitweb:        https://git.kernel.org/tip/0ae4061223a3d097222cbec6599370e54db17731
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 27 Sep 2019 12:01:26 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:29:22 -03:00

tools headers uapi: Sync linux/fs.h with the kernel sources

To pick the changes from:

  78a1b96bcf7a ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS ioctl")
  23c688b54016 ("fscrypt: allow unprivileged users to add/remove keys for v2 policies")
  5dae460c2292 ("fscrypt: v2 encryption policy support")
  5a7e29924dac ("fscrypt: add FS_IOC_GET_ENCRYPTION_KEY_STATUS ioctl")
  b1c0ec3599f4 ("fscrypt: add FS_IOC_REMOVE_ENCRYPTION_KEY ioctl")
  22d94f493bfb ("fscrypt: add FS_IOC_ADD_ENCRYPTION_KEY ioctl")
  3b6df59bc4d2 ("fscrypt: use FSCRYPT_* definitions, not FS_*")
  2336d0deb2d4 ("fscrypt: use FSCRYPT_ prefix for uapi constants")
  7af0ab0d3aab ("fs, fscrypt: move uapi definitions to new header <linux/fscrypt.h>")

That don't trigger any changes in tooling, as it so far is used only
for:

  $ grep -l 'fs\.h' tools/perf/trace/beauty/*.sh | xargs grep regex=
  tools/perf/trace/beauty/rename_flags.sh:regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+RENAME_([[:alnum:]_]+)[[:space:]]+\(1[[:space:]]*<<[[:space:]]*([[:xdigit:]]+)[[:space:]]*\)[[:space:]]*.*'
  tools/perf/trace/beauty/sync_file_range.sh:regex='^[[:space:]]*#[[:space:]]*define[[:space:]]+SYNC_FILE_RANGE_([[:alnum:]_]+)[[:space:]]+([[:xdigit:]]+)[[:space:]]*.*'
  tools/perf/trace/beauty/usbdevfs_ioctl.sh:regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)(\(\w+\))?[[:space:]]+_IO[CWR]{0,2}\([[:space:]]*(_IOC_\w+,[[:space:]]*)?'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
  tools/perf/trace/beauty/usbdevfs_ioctl.sh:regex="^#[[:space:]]*define[[:space:]]+USBDEVFS_(\w+)[[:space:]]+_IO[WR]{0,2}\([[:space:]]*'U'[[:space:]]*,[[:space:]]*([[:digit:]]+).*"
  $

This silences this perf build warning:

  Warning: Kernel ABI header at 'tools/include/uapi/linux/fs.h' differs from latest version at 'include/uapi/linux/fs.h'
  diff -u tools/include/uapi/linux/fs.h include/uapi/linux/fs.h

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Eric Biggers <ebiggers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-44g48exl9br9ba0t64chqb4i@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/uapi/linux/fs.h      |  55 +---------
 tools/include/uapi/linux/fscrypt.h | 181 ++++++++++++++++++++++++++++-
 tools/perf/check-headers.sh        |   1 +-
 3 files changed, 186 insertions(+), 51 deletions(-)
 create mode 100644 tools/include/uapi/linux/fscrypt.h

diff --git a/tools/include/uapi/linux/fs.h b/tools/include/uapi/linux/fs.h
index 2a616aa..379a612 100644
--- a/tools/include/uapi/linux/fs.h
+++ b/tools/include/uapi/linux/fs.h
@@ -13,6 +13,9 @@
 #include <linux/limits.h>
 #include <linux/ioctl.h>
 #include <linux/types.h>
+#ifndef __KERNEL__
+#include <linux/fscrypt.h>
+#endif
 
 /* Use of MS_* flags within the kernel is restricted to core mount(2) code. */
 #if !defined(__KERNEL__)
@@ -213,57 +216,6 @@ struct fsxattr {
 #define FS_IOC_SETFSLABEL		_IOW(0x94, 50, char[FSLABEL_MAX])
 
 /*
- * File system encryption support
- */
-/* Policy provided via an ioctl on the topmost directory */
-#define FS_KEY_DESCRIPTOR_SIZE	8
-
-#define FS_POLICY_FLAGS_PAD_4		0x00
-#define FS_POLICY_FLAGS_PAD_8		0x01
-#define FS_POLICY_FLAGS_PAD_16		0x02
-#define FS_POLICY_FLAGS_PAD_32		0x03
-#define FS_POLICY_FLAGS_PAD_MASK	0x03
-#define FS_POLICY_FLAG_DIRECT_KEY	0x04	/* use master key directly */
-#define FS_POLICY_FLAGS_VALID		0x07
-
-/* Encryption algorithms */
-#define FS_ENCRYPTION_MODE_INVALID		0
-#define FS_ENCRYPTION_MODE_AES_256_XTS		1
-#define FS_ENCRYPTION_MODE_AES_256_GCM		2
-#define FS_ENCRYPTION_MODE_AES_256_CBC		3
-#define FS_ENCRYPTION_MODE_AES_256_CTS		4
-#define FS_ENCRYPTION_MODE_AES_128_CBC		5
-#define FS_ENCRYPTION_MODE_AES_128_CTS		6
-#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8 /* Removed, do not use. */
-#define FS_ENCRYPTION_MODE_ADIANTUM		9
-
-struct fscrypt_policy {
-	__u8 version;
-	__u8 contents_encryption_mode;
-	__u8 filenames_encryption_mode;
-	__u8 flags;
-	__u8 master_key_descriptor[FS_KEY_DESCRIPTOR_SIZE];
-};
-
-#define FS_IOC_SET_ENCRYPTION_POLICY	_IOR('f', 19, struct fscrypt_policy)
-#define FS_IOC_GET_ENCRYPTION_PWSALT	_IOW('f', 20, __u8[16])
-#define FS_IOC_GET_ENCRYPTION_POLICY	_IOW('f', 21, struct fscrypt_policy)
-
-/* Parameters for passing an encryption key into the kernel keyring */
-#define FS_KEY_DESC_PREFIX		"fscrypt:"
-#define FS_KEY_DESC_PREFIX_SIZE		8
-
-/* Structure that userspace passes to the kernel keyring */
-#define FS_MAX_KEY_SIZE			64
-
-struct fscrypt_key {
-	__u32 mode;
-	__u8 raw[FS_MAX_KEY_SIZE];
-	__u32 size;
-};
-
-/*
  * Inode flags (FS_IOC_GETFLAGS / FS_IOC_SETFLAGS)
  *
  * Note: for historical reasons, these flags were originally used and
@@ -306,6 +258,7 @@ struct fscrypt_key {
 #define FS_TOPDIR_FL			0x00020000 /* Top of directory hierarchies*/
 #define FS_HUGE_FILE_FL			0x00040000 /* Reserved for ext4 */
 #define FS_EXTENT_FL			0x00080000 /* Extents */
+#define FS_VERITY_FL			0x00100000 /* Verity protected inode */
 #define FS_EA_INODE_FL			0x00200000 /* Inode used for large EA */
 #define FS_EOFBLOCKS_FL			0x00400000 /* Reserved for ext4 */
 #define FS_NOCOW_FL			0x00800000 /* Do not cow file */
diff --git a/tools/include/uapi/linux/fscrypt.h b/tools/include/uapi/linux/fscrypt.h
new file mode 100644
index 0000000..39ccfe9
--- /dev/null
+++ b/tools/include/uapi/linux/fscrypt.h
@@ -0,0 +1,181 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * fscrypt user API
+ *
+ * These ioctls can be used on filesystems that support fscrypt.  See the
+ * "User API" section of Documentation/filesystems/fscrypt.rst.
+ */
+#ifndef _UAPI_LINUX_FSCRYPT_H
+#define _UAPI_LINUX_FSCRYPT_H
+
+#include <linux/types.h>
+
+/* Encryption policy flags */
+#define FSCRYPT_POLICY_FLAGS_PAD_4		0x00
+#define FSCRYPT_POLICY_FLAGS_PAD_8		0x01
+#define FSCRYPT_POLICY_FLAGS_PAD_16		0x02
+#define FSCRYPT_POLICY_FLAGS_PAD_32		0x03
+#define FSCRYPT_POLICY_FLAGS_PAD_MASK		0x03
+#define FSCRYPT_POLICY_FLAG_DIRECT_KEY		0x04
+#define FSCRYPT_POLICY_FLAGS_VALID		0x07
+
+/* Encryption algorithms */
+#define FSCRYPT_MODE_AES_256_XTS		1
+#define FSCRYPT_MODE_AES_256_CTS		4
+#define FSCRYPT_MODE_AES_128_CBC		5
+#define FSCRYPT_MODE_AES_128_CTS		6
+#define FSCRYPT_MODE_ADIANTUM			9
+#define __FSCRYPT_MODE_MAX			9
+
+/*
+ * Legacy policy version; ad-hoc KDF and no key verification.
+ * For new encrypted directories, use fscrypt_policy_v2 instead.
+ *
+ * Careful: the .version field for this is actually 0, not 1.
+ */
+#define FSCRYPT_POLICY_V1		0
+#define FSCRYPT_KEY_DESCRIPTOR_SIZE	8
+struct fscrypt_policy_v1 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 master_key_descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+};
+#define fscrypt_policy	fscrypt_policy_v1
+
+/*
+ * Process-subscribed "logon" key description prefix and payload format.
+ * Deprecated; prefer FS_IOC_ADD_ENCRYPTION_KEY instead.
+ */
+#define FSCRYPT_KEY_DESC_PREFIX		"fscrypt:"
+#define FSCRYPT_KEY_DESC_PREFIX_SIZE	8
+#define FSCRYPT_MAX_KEY_SIZE		64
+struct fscrypt_key {
+	__u32 mode;
+	__u8 raw[FSCRYPT_MAX_KEY_SIZE];
+	__u32 size;
+};
+
+/*
+ * New policy version with HKDF and key verification (recommended).
+ */
+#define FSCRYPT_POLICY_V2		2
+#define FSCRYPT_KEY_IDENTIFIER_SIZE	16
+struct fscrypt_policy_v2 {
+	__u8 version;
+	__u8 contents_encryption_mode;
+	__u8 filenames_encryption_mode;
+	__u8 flags;
+	__u8 __reserved[4];
+	__u8 master_key_identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+};
+
+/* Struct passed to FS_IOC_GET_ENCRYPTION_POLICY_EX */
+struct fscrypt_get_policy_ex_arg {
+	__u64 policy_size; /* input/output */
+	union {
+		__u8 version;
+		struct fscrypt_policy_v1 v1;
+		struct fscrypt_policy_v2 v2;
+	} policy; /* output */
+};
+
+/*
+ * v1 policy keys are specified by an arbitrary 8-byte key "descriptor",
+ * matching fscrypt_policy_v1::master_key_descriptor.
+ */
+#define FSCRYPT_KEY_SPEC_TYPE_DESCRIPTOR	1
+
+/*
+ * v2 policy keys are specified by a 16-byte key "identifier" which the kernel
+ * calculates as a cryptographic hash of the key itself,
+ * matching fscrypt_policy_v2::master_key_identifier.
+ */
+#define FSCRYPT_KEY_SPEC_TYPE_IDENTIFIER	2
+
+/*
+ * Specifies a key, either for v1 or v2 policies.  This doesn't contain the
+ * actual key itself; this is just the "name" of the key.
+ */
+struct fscrypt_key_specifier {
+	__u32 type;	/* one of FSCRYPT_KEY_SPEC_TYPE_* */
+	__u32 __reserved;
+	union {
+		__u8 __reserved[32]; /* reserve some extra space */
+		__u8 descriptor[FSCRYPT_KEY_DESCRIPTOR_SIZE];
+		__u8 identifier[FSCRYPT_KEY_IDENTIFIER_SIZE];
+	} u;
+};
+
+/* Struct passed to FS_IOC_ADD_ENCRYPTION_KEY */
+struct fscrypt_add_key_arg {
+	struct fscrypt_key_specifier key_spec;
+	__u32 raw_size;
+	__u32 __reserved[9];
+	__u8 raw[];
+};
+
+/* Struct passed to FS_IOC_REMOVE_ENCRYPTION_KEY */
+struct fscrypt_remove_key_arg {
+	struct fscrypt_key_specifier key_spec;
+#define FSCRYPT_KEY_REMOVAL_STATUS_FLAG_FILES_BUSY	0x00000001
+#define FSCRYPT_KEY_REMOVAL_STATUS_FLAG_OTHER_USERS	0x00000002
+	__u32 removal_status_flags;	/* output */
+	__u32 __reserved[5];
+};
+
+/* Struct passed to FS_IOC_GET_ENCRYPTION_KEY_STATUS */
+struct fscrypt_get_key_status_arg {
+	/* input */
+	struct fscrypt_key_specifier key_spec;
+	__u32 __reserved[6];
+
+	/* output */
+#define FSCRYPT_KEY_STATUS_ABSENT		1
+#define FSCRYPT_KEY_STATUS_PRESENT		2
+#define FSCRYPT_KEY_STATUS_INCOMPLETELY_REMOVED	3
+	__u32 status;
+#define FSCRYPT_KEY_STATUS_FLAG_ADDED_BY_SELF   0x00000001
+	__u32 status_flags;
+	__u32 user_count;
+	__u32 __out_reserved[13];
+};
+
+#define FS_IOC_SET_ENCRYPTION_POLICY		_IOR('f', 19, struct fscrypt_policy)
+#define FS_IOC_GET_ENCRYPTION_PWSALT		_IOW('f', 20, __u8[16])
+#define FS_IOC_GET_ENCRYPTION_POLICY		_IOW('f', 21, struct fscrypt_policy)
+#define FS_IOC_GET_ENCRYPTION_POLICY_EX		_IOWR('f', 22, __u8[9]) /* size + version */
+#define FS_IOC_ADD_ENCRYPTION_KEY		_IOWR('f', 23, struct fscrypt_add_key_arg)
+#define FS_IOC_REMOVE_ENCRYPTION_KEY		_IOWR('f', 24, struct fscrypt_remove_key_arg)
+#define FS_IOC_REMOVE_ENCRYPTION_KEY_ALL_USERS	_IOWR('f', 25, struct fscrypt_remove_key_arg)
+#define FS_IOC_GET_ENCRYPTION_KEY_STATUS	_IOWR('f', 26, struct fscrypt_get_key_status_arg)
+
+/**********************************************************************/
+
+/* old names; don't add anything new here! */
+#ifndef __KERNEL__
+#define FS_KEY_DESCRIPTOR_SIZE		FSCRYPT_KEY_DESCRIPTOR_SIZE
+#define FS_POLICY_FLAGS_PAD_4		FSCRYPT_POLICY_FLAGS_PAD_4
+#define FS_POLICY_FLAGS_PAD_8		FSCRYPT_POLICY_FLAGS_PAD_8
+#define FS_POLICY_FLAGS_PAD_16		FSCRYPT_POLICY_FLAGS_PAD_16
+#define FS_POLICY_FLAGS_PAD_32		FSCRYPT_POLICY_FLAGS_PAD_32
+#define FS_POLICY_FLAGS_PAD_MASK	FSCRYPT_POLICY_FLAGS_PAD_MASK
+#define FS_POLICY_FLAG_DIRECT_KEY	FSCRYPT_POLICY_FLAG_DIRECT_KEY
+#define FS_POLICY_FLAGS_VALID		FSCRYPT_POLICY_FLAGS_VALID
+#define FS_ENCRYPTION_MODE_INVALID	0	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_XTS	FSCRYPT_MODE_AES_256_XTS
+#define FS_ENCRYPTION_MODE_AES_256_GCM	2	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_CBC	3	/* never used */
+#define FS_ENCRYPTION_MODE_AES_256_CTS	FSCRYPT_MODE_AES_256_CTS
+#define FS_ENCRYPTION_MODE_AES_128_CBC	FSCRYPT_MODE_AES_128_CBC
+#define FS_ENCRYPTION_MODE_AES_128_CTS	FSCRYPT_MODE_AES_128_CTS
+#define FS_ENCRYPTION_MODE_SPECK128_256_XTS	7	/* removed */
+#define FS_ENCRYPTION_MODE_SPECK128_256_CTS	8	/* removed */
+#define FS_ENCRYPTION_MODE_ADIANTUM	FSCRYPT_MODE_ADIANTUM
+#define FS_KEY_DESC_PREFIX		FSCRYPT_KEY_DESC_PREFIX
+#define FS_KEY_DESC_PREFIX_SIZE		FSCRYPT_KEY_DESC_PREFIX_SIZE
+#define FS_MAX_KEY_SIZE			FSCRYPT_MAX_KEY_SIZE
+#endif /* !__KERNEL__ */
+
+#endif /* _UAPI_LINUX_FSCRYPT_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index e2e0f06..cea13cb 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -8,6 +8,7 @@ include/uapi/drm/i915_drm.h
 include/uapi/linux/fadvise.h
 include/uapi/linux/fcntl.h
 include/uapi/linux/fs.h
+include/uapi/linux/fscrypt.h
 include/uapi/linux/kcmp.h
 include/uapi/linux/kvm.h
 include/uapi/linux/in.h
