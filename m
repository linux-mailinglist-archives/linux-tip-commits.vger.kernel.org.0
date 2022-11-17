Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4CBA62E736
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Nov 2022 22:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239352AbiKQVnh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 17 Nov 2022 16:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiKQVna (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 17 Nov 2022 16:43:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC50FD9;
        Thu, 17 Nov 2022 13:43:26 -0800 (PST)
Date:   Thu, 17 Nov 2022 21:43:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668721404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D6aHE4H/sb4o9v0J7YusOZwvrP2mRJaVHuXId5MvrcM=;
        b=a0WKR9zuVGcy8mQcNM2tHYJbPnbl/aUrtgcw0Qx+bL9encZ7NtcR/AH95g14DWDe/8JVQb
        TQWqYf1FyAhg4wUTL7KLr90XFI0hTfggCfLruKdzeyQWeUZ25Sk498tCTgNU/NH7eSbJF7
        y+ArfnC0+m45TiBn7azbvmntkk25oabe/XbsxI1cFXCi2DxgbObLRCQ6GuclnGfNUZVzRL
        LzUEmUrSvhPxsGQ2qoN9OEoTiygd0VB3uP6sgJwN89cfrCMwo9DLzrGX6i6dUfgIpOzjVl
        l6GcdlABnQ+iVFbB+wd2UDIoBE8v4xdEr8vaZkljeoVR0cQvEzdfFZY1xuS8jA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668721404;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D6aHE4H/sb4o9v0J7YusOZwvrP2mRJaVHuXId5MvrcM=;
        b=zhxasNYQefTTO0FwqoHvwOjNxeBxzI4fnTAgHR9ZrOgm0yKZzIhRGfGIuQXzHwOW0wqrIF
        KOl/QirjHjugMtCg==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] selftests/tdx: Test TDX attestation GetReport support
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        Wander Lairson Costa <wander@redhat.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166872140279.4906.17151458842303662524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     00e07cfbdf0b232f7553f0175f8f4e8d792f7e90
Gitweb:        https://git.kernel.org/tip/00e07cfbdf0b232f7553f0175f8f4e8d792f7e90
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 16 Nov 2022 14:38:20 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Nov 2022 11:04:28 -08:00

selftests/tdx: Test TDX attestation GetReport support

Attestation is used to verify the trustworthiness of a TDX guest.
During the guest bring-up, the Intel TDX module measures and records
the initial contents and configuration of the guest, and at runtime,
guest software uses runtime measurement registers (RMTRs) to measure
and record details related to kernel image, command line params, ACPI
tables, initrd, etc. At guest runtime, the attestation process is used
to attest to these measurements.

The first step in the TDX attestation process is to get the TDREPORT
data. It is a fixed size data structure generated by the TDX module
which includes the above mentioned measurements data, a MAC ID to
protect the integrity of the TDREPORT, and a 64-Byte of user specified
data passed during TDREPORT request which can uniquely identify the
TDREPORT.

Intel's TDX guest driver exposes TDX_CMD_GET_REPORT0 IOCTL interface to
enable guest userspace to get the TDREPORT subtype 0.

Add a kernel self test module to test this ABI and verify the validity
of the generated TDREPORT.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Wander Lairson Costa <wander@redhat.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20221116223820.819090-4-sathyanarayanan.kuppuswamy%40linux.intel.com
---
 tools/testing/selftests/Makefile             |   1 +-
 tools/testing/selftests/tdx/Makefile         |   7 +-
 tools/testing/selftests/tdx/config           |   1 +-
 tools/testing/selftests/tdx/tdx_guest_test.c | 163 ++++++++++++++++++-
 4 files changed, 172 insertions(+)
 create mode 100644 tools/testing/selftests/tdx/Makefile
 create mode 100644 tools/testing/selftests/tdx/config
 create mode 100644 tools/testing/selftests/tdx/tdx_guest_test.c

diff --git a/tools/testing/selftests/Makefile b/tools/testing/selftests/Makefile
index f07aef7..bc63c69 100644
--- a/tools/testing/selftests/Makefile
+++ b/tools/testing/selftests/Makefile
@@ -74,6 +74,7 @@ TARGETS += sync
 TARGETS += syscall_user_dispatch
 TARGETS += sysctl
 TARGETS += tc-testing
+TARGETS += tdx
 TARGETS += timens
 ifneq (1, $(quicktest))
 TARGETS += timers
diff --git a/tools/testing/selftests/tdx/Makefile b/tools/testing/selftests/tdx/Makefile
new file mode 100644
index 0000000..8dd4351
--- /dev/null
+++ b/tools/testing/selftests/tdx/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+
+CFLAGS += -O3 -Wl,-no-as-needed -Wall -static
+
+TEST_GEN_PROGS := tdx_guest_test
+
+include ../lib.mk
diff --git a/tools/testing/selftests/tdx/config b/tools/testing/selftests/tdx/config
new file mode 100644
index 0000000..aa1edc8
--- /dev/null
+++ b/tools/testing/selftests/tdx/config
@@ -0,0 +1 @@
+CONFIG_TDX_GUEST_DRIVER=y
diff --git a/tools/testing/selftests/tdx/tdx_guest_test.c b/tools/testing/selftests/tdx/tdx_guest_test.c
new file mode 100644
index 0000000..2a2afd8
--- /dev/null
+++ b/tools/testing/selftests/tdx/tdx_guest_test.c
@@ -0,0 +1,163 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Test TDX guest features
+ *
+ * Copyright (C) 2022 Intel Corporation.
+ *
+ * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
+ */
+
+#include <sys/ioctl.h>
+
+#include <errno.h>
+#include <fcntl.h>
+
+#include "../kselftest_harness.h"
+#include "../../../../include/uapi/linux/tdx-guest.h"
+
+#define TDX_GUEST_DEVNAME "/dev/tdx_guest"
+#define HEX_DUMP_SIZE 8
+#define DEBUG 0
+
+/**
+ * struct tdreport_type - Type header of TDREPORT_STRUCT.
+ * @type: Type of the TDREPORT (0 - SGX, 81 - TDX, rest are reserved)
+ * @sub_type: Subtype of the TDREPORT (Default value is 0).
+ * @version: TDREPORT version (Default value is 0).
+ * @reserved: Added for future extension.
+ *
+ * More details can be found in TDX v1.0 module specification, sec
+ * titled "REPORTTYPE".
+ */
+struct tdreport_type {
+	__u8 type;
+	__u8 sub_type;
+	__u8 version;
+	__u8 reserved;
+};
+
+/**
+ * struct reportmac - TDX guest report data, MAC and TEE hashes.
+ * @type: TDREPORT type header.
+ * @reserved1: Reserved for future extension.
+ * @cpu_svn: CPU security version.
+ * @tee_tcb_info_hash: SHA384 hash of TEE TCB INFO.
+ * @tee_td_info_hash: SHA384 hash of TDINFO_STRUCT.
+ * @reportdata: User defined unique data passed in TDG.MR.REPORT request.
+ * @reserved2: Reserved for future extension.
+ * @mac: CPU MAC ID.
+ *
+ * It is MAC-protected and contains hashes of the remainder of the
+ * report structure along with user provided report data. More details can
+ * be found in TDX v1.0 Module specification, sec titled "REPORTMACSTRUCT"
+ */
+struct reportmac {
+	struct tdreport_type type;
+	__u8 reserved1[12];
+	__u8 cpu_svn[16];
+	__u8 tee_tcb_info_hash[48];
+	__u8 tee_td_info_hash[48];
+	__u8 reportdata[64];
+	__u8 reserved2[32];
+	__u8 mac[32];
+};
+
+/**
+ * struct td_info - TDX guest measurements and configuration.
+ * @attr: TDX Guest attributes (like debug, spet_disable, etc).
+ * @xfam: Extended features allowed mask.
+ * @mrtd: Build time measurement register.
+ * @mrconfigid: Software-defined ID for non-owner-defined configuration
+ *              of the guest - e.g., run-time or OS configuration.
+ * @mrowner: Software-defined ID for the guest owner.
+ * @mrownerconfig: Software-defined ID for owner-defined configuration of
+ *                 the guest - e.g., specific to the workload.
+ * @rtmr: Run time measurement registers.
+ * @reserved: Added for future extension.
+ *
+ * It contains the measurements and initial configuration of the TDX guest
+ * that was locked at initialization and a set of measurement registers
+ * that are run-time extendable. More details can be found in TDX v1.0
+ * Module specification, sec titled "TDINFO_STRUCT".
+ */
+struct td_info {
+	__u8 attr[8];
+	__u64 xfam;
+	__u64 mrtd[6];
+	__u64 mrconfigid[6];
+	__u64 mrowner[6];
+	__u64 mrownerconfig[6];
+	__u64 rtmr[24];
+	__u64 reserved[14];
+};
+
+/*
+ * struct tdreport - Output of TDCALL[TDG.MR.REPORT].
+ * @reportmac: Mac protected header of size 256 bytes.
+ * @tee_tcb_info: Additional attestable elements in the TCB are not
+ *                reflected in the reportmac.
+ * @reserved: Added for future extension.
+ * @tdinfo: Measurements and configuration data of size 512 bytes.
+ *
+ * More details can be found in TDX v1.0 Module specification, sec
+ * titled "TDREPORT_STRUCT".
+ */
+struct tdreport {
+	struct reportmac reportmac;
+	__u8 tee_tcb_info[239];
+	__u8 reserved[17];
+	struct td_info tdinfo;
+};
+
+static void print_array_hex(const char *title, const char *prefix_str,
+			    const void *buf, int len)
+{
+	int i, j, line_len, rowsize = HEX_DUMP_SIZE;
+	const __u8 *ptr = buf;
+
+	printf("\t\t%s", title);
+
+	for (j = 0; j < len; j += rowsize) {
+		line_len = rowsize < (len - j) ? rowsize : (len - j);
+		printf("%s%.8x:", prefix_str, j);
+		for (i = 0; i < line_len; i++)
+			printf(" %.2x", ptr[j + i]);
+		printf("\n");
+	}
+
+	printf("\n");
+}
+
+TEST(verify_report)
+{
+	struct tdx_report_req req;
+	struct tdreport *tdreport;
+	int devfd, i;
+
+	devfd = open(TDX_GUEST_DEVNAME, O_RDWR | O_SYNC);
+	ASSERT_LT(0, devfd);
+
+	/* Generate sample report data */
+	for (i = 0; i < TDX_REPORTDATA_LEN; i++)
+		req.reportdata[i] = i;
+
+	/* Get TDREPORT */
+	ASSERT_EQ(0, ioctl(devfd, TDX_CMD_GET_REPORT0, &req));
+
+	if (DEBUG) {
+		print_array_hex("\n\t\tTDX report data\n", "",
+				req.reportdata, sizeof(req.reportdata));
+
+		print_array_hex("\n\t\tTDX tdreport data\n", "",
+				req.tdreport, sizeof(req.tdreport));
+	}
+
+	/* Make sure TDREPORT data includes the REPORTDATA passed */
+	tdreport = (struct tdreport *)req.tdreport;
+	ASSERT_EQ(0, memcmp(&tdreport->reportmac.reportdata[0],
+			    req.reportdata, sizeof(req.reportdata)));
+
+	ASSERT_EQ(0, close(devfd));
+}
+
+TEST_HARNESS_MAIN
