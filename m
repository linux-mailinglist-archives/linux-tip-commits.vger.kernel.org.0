Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB29B62E737
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Nov 2022 22:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiKQVnh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 17 Nov 2022 16:43:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234813AbiKQVna (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 17 Nov 2022 16:43:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFFEFF9;
        Thu, 17 Nov 2022 13:43:26 -0800 (PST)
Date:   Thu, 17 Nov 2022 21:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1668721405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/cfoaGUYGnOcP6sqwwbptC/O/KOePWisbpdkH2xUaxw=;
        b=OI+tNDMVzxbGwQoEDWUBFnaG7QMXo5X1vaIXL0/f/b0mxEFL//sGZ5DSdZWJy1xJhWp7ie
        elOCwpluIM3zTAu3zwFmLRJsQByi8Fiib+oBKPPH1wyBGNfTUy6iAIfvBlVp5kr7W6kvtj
        1DzbHjN06NcRw6Wea43ou2MgtW+F3w40rTTmHVhbsUDE4NLhIya6mU12Wq3tfmW1+xzBEz
        aj1W/sWGzRqYUfbClIMTTh2ZqnnabvEvOIB9iZizpXWnTsG4CTy+UUoHEH8WlY8FdIIbeg
        21oeo8zAH9wmSAz+5QWof++F6GOBvaWDWvelnFbA4q89FHiqL7M0sT3hDTiumQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1668721405;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/cfoaGUYGnOcP6sqwwbptC/O/KOePWisbpdkH2xUaxw=;
        b=Fu4XXOXyUdRQB5TMwvb4efv5robDMaWPwVGIeWSfEgXmoC1McmqmDLLIXGOLYzMqIVNEdP
        GFJGjyffKbu0l7BA==
From:   "tip-bot2 for Kuppuswamy Sathyanarayanan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] virt: Add TDX guest driver
Cc:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Wander Lairson Costa <wander@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <166872140395.4906.7561084756424988264.tip-bot2@tip-bot2>
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

Commit-ID:     6c8c1406a6d6a3f2e61ac590f5c0994231bc6be7
Gitweb:        https://git.kernel.org/tip/6c8c1406a6d6a3f2e61ac590f5c0994231bc6be7
Author:        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
AuthorDate:    Wed, 16 Nov 2022 14:38:19 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 17 Nov 2022 11:04:23 -08:00

virt: Add TDX guest driver

TDX guest driver exposes IOCTL interfaces to service TDX guest
user-specific requests. Currently, it is only used to allow the user to
get the TDREPORT to support TDX attestation.

Details about the TDX attestation process are documented in
Documentation/x86/tdx.rst, and the IOCTL details are documented in
Documentation/virt/coco/tdx-guest.rst.

Operations like getting TDREPORT involves sending a blob of data as
input and getting another blob of data as output. It was considered
to use a sysfs interface for this, but it doesn't fit well into the
standard sysfs model for configuring values. It would be possible to
do read/write on files, but it would need multiple file descriptors,
which would be somewhat messy. IOCTLs seem to be the best fitting
and simplest model for this use case. The AMD sev-guest driver also
uses the IOCTL interface to support attestation.

[Bagas Sanjaya: Ack is for documentation portion]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Wander Lairson Costa <wander@redhat.com>
Link: https://lore.kernel.org/all/20221116223820.819090-3-sathyanarayanan.kuppuswamy%40linux.intel.com
---
 Documentation/virt/coco/tdx-guest.rst   |  52 ++++++++++++-
 Documentation/virt/index.rst            |   1 +-
 Documentation/x86/tdx.rst               |  43 ++++++++++-
 drivers/virt/Kconfig                    |   2 +-
 drivers/virt/Makefile                   |   1 +-
 drivers/virt/coco/tdx-guest/Kconfig     |  10 ++-
 drivers/virt/coco/tdx-guest/Makefile    |   2 +-
 drivers/virt/coco/tdx-guest/tdx-guest.c | 102 +++++++++++++++++++++++-
 include/uapi/linux/tdx-guest.h          |  42 +++++++++-
 9 files changed, 255 insertions(+)
 create mode 100644 Documentation/virt/coco/tdx-guest.rst
 create mode 100644 drivers/virt/coco/tdx-guest/Kconfig
 create mode 100644 drivers/virt/coco/tdx-guest/Makefile
 create mode 100644 drivers/virt/coco/tdx-guest/tdx-guest.c
 create mode 100644 include/uapi/linux/tdx-guest.h

diff --git a/Documentation/virt/coco/tdx-guest.rst b/Documentation/virt/coco/tdx-guest.rst
new file mode 100644
index 0000000..46e316d
--- /dev/null
+++ b/Documentation/virt/coco/tdx-guest.rst
@@ -0,0 +1,52 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+TDX Guest API Documentation
+===================================================================
+
+1. General description
+======================
+
+The TDX guest driver exposes IOCTL interfaces via the /dev/tdx-guest misc
+device to allow userspace to get certain TDX guest-specific details.
+
+2. API description
+==================
+
+In this section, for each supported IOCTL, the following information is
+provided along with a generic description.
+
+:Input parameters: Parameters passed to the IOCTL and related details.
+:Output: Details about output data and return value (with details about
+         the non common error values).
+
+2.1 TDX_CMD_GET_REPORT0
+-----------------------
+
+:Input parameters: struct tdx_report_req
+:Output: Upon successful execution, TDREPORT data is copied to
+         tdx_report_req.tdreport and return 0. Return -EINVAL for invalid
+         operands, -EIO on TDCALL failure or standard error number on other
+         common failures.
+
+The TDX_CMD_GET_REPORT0 IOCTL can be used by the attestation software to get
+the TDREPORT0 (a.k.a. TDREPORT subtype 0) from the TDX module using
+TDCALL[TDG.MR.REPORT].
+
+A subtype index is added at the end of this IOCTL CMD to uniquely identify the
+subtype-specific TDREPORT request. Although the subtype option is mentioned in
+the TDX Module v1.0 specification, section titled "TDG.MR.REPORT", it is not
+currently used, and it expects this value to be 0. So to keep the IOCTL
+implementation simple, the subtype option was not included as part of the input
+ABI. However, in the future, if the TDX Module supports more than one subtype,
+a new IOCTL CMD will be created to handle it. To keep the IOCTL naming
+consistent, a subtype index is added as part of the IOCTL CMD.
+
+Reference
+---------
+
+TDX reference material is collected here:
+
+https://www.intel.com/content/www/us/en/developer/articles/technical/intel-trust-domain-extensions.html
+
+The driver is based on TDX module specification v1.0 and TDX GHCI specification v1.0.
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 2f1cffa..56e003f 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -14,6 +14,7 @@ Linux Virtualization Support
    ne_overview
    acrn/index
    coco/sev-guest
+   coco/tdx-guest
    hyperv/index
 
 .. only:: html and subproject
diff --git a/Documentation/x86/tdx.rst b/Documentation/x86/tdx.rst
index b8fa432..dc8d9fd 100644
--- a/Documentation/x86/tdx.rst
+++ b/Documentation/x86/tdx.rst
@@ -210,6 +210,49 @@ converted to shared on boot.
 For coherent DMA allocation, the DMA buffer gets converted on the
 allocation. Check force_dma_unencrypted() for details.
 
+Attestation
+===========
+
+Attestation is used to verify the TDX guest trustworthiness to other
+entities before provisioning secrets to the guest. For example, a key
+server may want to use attestation to verify that the guest is the
+desired one before releasing the encryption keys to mount the encrypted
+rootfs or a secondary drive.
+
+The TDX module records the state of the TDX guest in various stages of
+the guest boot process using the build time measurement register (MRTD)
+and runtime measurement registers (RTMR). Measurements related to the
+guest initial configuration and firmware image are recorded in the MRTD
+register. Measurements related to initial state, kernel image, firmware
+image, command line options, initrd, ACPI tables, etc are recorded in
+RTMR registers. For more details, as an example, please refer to TDX
+Virtual Firmware design specification, section titled "TD Measurement".
+At TDX guest runtime, the attestation process is used to attest to these
+measurements.
+
+The attestation process consists of two steps: TDREPORT generation and
+Quote generation.
+
+TDX guest uses TDCALL[TDG.MR.REPORT] to get the TDREPORT (TDREPORT_STRUCT)
+from the TDX module. TDREPORT is a fixed-size data structure generated by
+the TDX module which contains guest-specific information (such as build
+and boot measurements), platform security version, and the MAC to protect
+the integrity of the TDREPORT. A user-provided 64-Byte REPORTDATA is used
+as input and included in the TDREPORT. Typically it can be some nonce
+provided by attestation service so the TDREPORT can be verified uniquely.
+More details about the TDREPORT can be found in Intel TDX Module
+specification, section titled "TDG.MR.REPORT Leaf".
+
+After getting the TDREPORT, the second step of the attestation process
+is to send it to the Quoting Enclave (QE) to generate the Quote. TDREPORT
+by design can only be verified on the local platform as the MAC key is
+bound to the platform. To support remote verification of the TDREPORT,
+TDX leverages Intel SGX Quoting Enclave to verify the TDREPORT locally
+and convert it to a remotely verifiable Quote. Method of sending TDREPORT
+to QE is implementation specific. Attestation software can choose
+whatever communication channel available (i.e. vsock or TCP/IP) to
+send the TDREPORT to QE and receive the Quote.
+
 References
 ==========
 
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 87ef258..f79ab13 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -52,4 +52,6 @@ source "drivers/virt/coco/efi_secret/Kconfig"
 
 source "drivers/virt/coco/sev-guest/Kconfig"
 
+source "drivers/virt/coco/tdx-guest/Kconfig"
+
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 093674e..e9aa6fc 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -11,3 +11,4 @@ obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
 obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
 obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
+obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
new file mode 100644
index 0000000..14246fc
--- /dev/null
+++ b/drivers/virt/coco/tdx-guest/Kconfig
@@ -0,0 +1,10 @@
+config TDX_GUEST_DRIVER
+	tristate "TDX Guest driver"
+	depends on INTEL_TDX_GUEST
+	help
+	  The driver provides userspace interface to communicate with
+	  the TDX module to request the TDX guest details like attestation
+	  report.
+
+	  To compile this driver as module, choose M here. The module will
+	  be called tdx-guest.
diff --git a/drivers/virt/coco/tdx-guest/Makefile b/drivers/virt/coco/tdx-guest/Makefile
new file mode 100644
index 0000000..775cb46
--- /dev/null
+++ b/drivers/virt/coco/tdx-guest/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_TDX_GUEST_DRIVER) += tdx-guest.o
diff --git a/drivers/virt/coco/tdx-guest/tdx-guest.c b/drivers/virt/coco/tdx-guest/tdx-guest.c
new file mode 100644
index 0000000..5e44a0f
--- /dev/null
+++ b/drivers/virt/coco/tdx-guest/tdx-guest.c
@@ -0,0 +1,102 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * TDX guest user interface driver
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#include <linux/kernel.h>
+#include <linux/miscdevice.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/string.h>
+#include <linux/uaccess.h>
+
+#include <uapi/linux/tdx-guest.h>
+
+#include <asm/cpu_device_id.h>
+#include <asm/tdx.h>
+
+static long tdx_get_report0(struct tdx_report_req __user *req)
+{
+	u8 *reportdata, *tdreport;
+	long ret;
+
+	reportdata = kmalloc(TDX_REPORTDATA_LEN, GFP_KERNEL);
+	if (!reportdata)
+		return -ENOMEM;
+
+	tdreport = kzalloc(TDX_REPORT_LEN, GFP_KERNEL);
+	if (!tdreport) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	if (copy_from_user(reportdata, req->reportdata, TDX_REPORTDATA_LEN)) {
+		ret = -EFAULT;
+		goto out;
+	}
+
+	/* Generate TDREPORT0 using "TDG.MR.REPORT" TDCALL */
+	ret = tdx_mcall_get_report0(reportdata, tdreport);
+	if (ret)
+		goto out;
+
+	if (copy_to_user(req->tdreport, tdreport, TDX_REPORT_LEN))
+		ret = -EFAULT;
+
+out:
+	kfree(reportdata);
+	kfree(tdreport);
+
+	return ret;
+}
+
+static long tdx_guest_ioctl(struct file *file, unsigned int cmd,
+			    unsigned long arg)
+{
+	switch (cmd) {
+	case TDX_CMD_GET_REPORT0:
+		return tdx_get_report0((struct tdx_report_req __user *)arg);
+	default:
+		return -ENOTTY;
+	}
+}
+
+static const struct file_operations tdx_guest_fops = {
+	.owner = THIS_MODULE,
+	.unlocked_ioctl = tdx_guest_ioctl,
+	.llseek = no_llseek,
+};
+
+static struct miscdevice tdx_misc_dev = {
+	.name = KBUILD_MODNAME,
+	.minor = MISC_DYNAMIC_MINOR,
+	.fops = &tdx_guest_fops,
+};
+
+static const struct x86_cpu_id tdx_guest_ids[] = {
+	X86_MATCH_FEATURE(X86_FEATURE_TDX_GUEST, NULL),
+	{}
+};
+MODULE_DEVICE_TABLE(x86cpu, tdx_guest_ids);
+
+static int __init tdx_guest_init(void)
+{
+	if (!x86_match_cpu(tdx_guest_ids))
+		return -ENODEV;
+
+	return misc_register(&tdx_misc_dev);
+}
+module_init(tdx_guest_init);
+
+static void __exit tdx_guest_exit(void)
+{
+	misc_deregister(&tdx_misc_dev);
+}
+module_exit(tdx_guest_exit);
+
+MODULE_AUTHOR("Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>");
+MODULE_DESCRIPTION("TDX Guest Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/linux/tdx-guest.h b/include/uapi/linux/tdx-guest.h
new file mode 100644
index 0000000..a6a2098
--- /dev/null
+++ b/include/uapi/linux/tdx-guest.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Userspace interface for TDX guest driver
+ *
+ * Copyright (C) 2022 Intel Corporation
+ */
+
+#ifndef _UAPI_LINUX_TDX_GUEST_H_
+#define _UAPI_LINUX_TDX_GUEST_H_
+
+#include <linux/ioctl.h>
+#include <linux/types.h>
+
+/* Length of the REPORTDATA used in TDG.MR.REPORT TDCALL */
+#define TDX_REPORTDATA_LEN              64
+
+/* Length of TDREPORT used in TDG.MR.REPORT TDCALL */
+#define TDX_REPORT_LEN                  1024
+
+/**
+ * struct tdx_report_req - Request struct for TDX_CMD_GET_REPORT0 IOCTL.
+ *
+ * @reportdata: User buffer with REPORTDATA to be included into TDREPORT.
+ *              Typically it can be some nonce provided by attestation
+ *              service, so the generated TDREPORT can be uniquely verified.
+ * @tdreport: User buffer to store TDREPORT output from TDCALL[TDG.MR.REPORT].
+ */
+struct tdx_report_req {
+	__u8 reportdata[TDX_REPORTDATA_LEN];
+	__u8 tdreport[TDX_REPORT_LEN];
+};
+
+/*
+ * TDX_CMD_GET_REPORT0 - Get TDREPORT0 (a.k.a. TDREPORT subtype 0) using
+ *                       TDCALL[TDG.MR.REPORT]
+ *
+ * Return 0 on success, -EIO on TDCALL execution failure, and
+ * standard errno on other general error cases.
+ */
+#define TDX_CMD_GET_REPORT0              _IOWR('T', 1, struct tdx_report_req)
+
+#endif /* _UAPI_LINUX_TDX_GUEST_H_ */
