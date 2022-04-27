Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5A951178E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Apr 2022 14:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbiD0L7o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Apr 2022 07:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbiD0L7l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Apr 2022 07:59:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24D331504;
        Wed, 27 Apr 2022 04:56:27 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:56:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651060586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTsORsE/rRr5X2uwib6pfLzmW0dfeXSfdf9BDozbftw=;
        b=qsE5Kff3NVqYREWNuI60vC/4X4739M3DV9Z088P2JEm0MvUFFb2P0f7uch3Ev9h/olyA8Y
        kdbNoNc1dLmwQttpUXjYr74B097xHliiwVIsLF//9gHGcSoYJ1iSAD64FTVEfdMxOhGEHk
        xPSYzT91+IQ2ndQUn+iMDIOJJr01yRP3MIgpFo5uZAnlCRq1O3kMmFuYEdSezwUsasLPbQ
        s8yWsmpbg/fo4YTqYW2CLXC6QO4726HC3RLhQj2st3B/rCBaoHiUcRy1HKixjCxQWB5e7X
        q5aP3VwTIGRf22RepWjL1+DJEdXQvN6mdqKJKK9gN5sAJVMYqbu6i48veMJlqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651060586;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wTsORsE/rRr5X2uwib6pfLzmW0dfeXSfdf9BDozbftw=;
        b=me79EJ/oOQx0kBHu86U1veDYKbf1dwnKZk8eHlHBj1OKmhE+uqUsfGy5Rq0Qi6eO/uhhXa
        +q4QxYjpA7qN7lDg==
From:   "tip-bot2 for Tom Lendacky" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] virt: sevguest: Rename the sevguest dir and files to sev-guest
Cc:     Tom Lendacky <thomas.lendacky@amd.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C2f5c9cb16e3a67599c8e3170f6c72c8712c47d53=2E16504?=
 =?utf-8?q?64054=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C2f5c9cb16e3a67599c8e3170f6c72c8712c47d53=2E165046?=
 =?utf-8?q?4054=2Egit=2Ethomas=2Elendacky=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165106058475.4207.963307247999381937.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     d63670d23e60f00210635ca7c62bce27bec55f1b
Gitweb:        https://git.kernel.org/tip/d63670d23e60f00210635ca7c62bce27bec55f1b
Author:        Tom Lendacky <thomas.lendacky@amd.com>
AuthorDate:    Wed, 20 Apr 2022 09:14:14 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 27 Apr 2022 13:29:56 +02:00

virt: sevguest: Rename the sevguest dir and files to sev-guest

Rename the drivers/virt/coco/sevguest directory and files to sev-guest
so as to match the driver name.

  [ bp: Rename Documentation/virt/coco/sevguest.rst too, as reported by sfr:
    https://lore.kernel.org/r/20220427101059.3bf55262@canb.auug.org.au ]

Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/2f5c9cb16e3a67599c8e3170f6c72c8712c47d53.1650464054.git.thomas.lendacky@amd.com
---
 Documentation/virt/coco/sev-guest.rst   | 155 +++++-
 Documentation/virt/coco/sevguest.rst    | 155 +-----
 Documentation/virt/index.rst            |   2 +-
 drivers/virt/Kconfig                    |   2 +-
 drivers/virt/Makefile                   |   2 +-
 drivers/virt/coco/sev-guest/Kconfig     |  14 +-
 drivers/virt/coco/sev-guest/Makefile    |   2 +-
 drivers/virt/coco/sev-guest/sev-guest.c | 743 +++++++++++++++++++++++-
 drivers/virt/coco/sev-guest/sev-guest.h |  98 +++-
 drivers/virt/coco/sevguest/Kconfig      |  14 +-
 drivers/virt/coco/sevguest/Makefile     |   2 +-
 drivers/virt/coco/sevguest/sevguest.c   | 743 +-----------------------
 drivers/virt/coco/sevguest/sevguest.h   |  98 +---
 13 files changed, 1015 insertions(+), 1015 deletions(-)
 create mode 100644 Documentation/virt/coco/sev-guest.rst
 delete mode 100644 Documentation/virt/coco/sevguest.rst
 create mode 100644 drivers/virt/coco/sev-guest/Kconfig
 create mode 100644 drivers/virt/coco/sev-guest/Makefile
 create mode 100644 drivers/virt/coco/sev-guest/sev-guest.c
 create mode 100644 drivers/virt/coco/sev-guest/sev-guest.h
 delete mode 100644 drivers/virt/coco/sevguest/Kconfig
 delete mode 100644 drivers/virt/coco/sevguest/Makefile
 delete mode 100644 drivers/virt/coco/sevguest/sevguest.c
 delete mode 100644 drivers/virt/coco/sevguest/sevguest.h

diff --git a/Documentation/virt/coco/sev-guest.rst b/Documentation/virt/coco/sev-guest.rst
new file mode 100644
index 0000000..bf593e8
--- /dev/null
+++ b/Documentation/virt/coco/sev-guest.rst
@@ -0,0 +1,155 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+===================================================================
+The Definitive SEV Guest API Documentation
+===================================================================
+
+1. General description
+======================
+
+The SEV API is a set of ioctls that are used by the guest or hypervisor
+to get or set a certain aspect of the SEV virtual machine. The ioctls belong
+to the following classes:
+
+ - Hypervisor ioctls: These query and set global attributes which affect the
+   whole SEV firmware.  These ioctl are used by platform provisioning tools.
+
+ - Guest ioctls: These query and set attributes of the SEV virtual machine.
+
+2. API description
+==================
+
+This section describes ioctls that is used for querying the SEV guest report
+from the SEV firmware. For each ioctl, the following information is provided
+along with a description:
+
+  Technology:
+      which SEV technology provides this ioctl. SEV, SEV-ES, SEV-SNP or all.
+
+  Type:
+      hypervisor or guest. The ioctl can be used inside the guest or the
+      hypervisor.
+
+  Parameters:
+      what parameters are accepted by the ioctl.
+
+  Returns:
+      the return value.  General error numbers (-ENOMEM, -EINVAL)
+      are not detailed, but errors with specific meanings are.
+
+The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
+The ioctl accepts struct snp_user_guest_request. The input and output structure is
+specified through the req_data and resp_data field respectively. If the ioctl fails
+to execute due to a firmware error, then fw_err code will be set otherwise the
+fw_err will be set to 0x00000000000000ff.
+
+The firmware checks that the message sequence counter is one greater than
+the guests message sequence counter. If guest driver fails to increment message
+counter (e.g. counter overflow), then -EIO will be returned.
+
+::
+
+        struct snp_guest_request_ioctl {
+                /* Message version number */
+                __u32 msg_version;
+
+                /* Request and response structure address */
+                __u64 req_data;
+                __u64 resp_data;
+
+                /* firmware error code on failure (see psp-sev.h) */
+                __u64 fw_err;
+        };
+
+2.1 SNP_GET_REPORT
+------------------
+
+:Technology: sev-snp
+:Type: guest ioctl
+:Parameters (in): struct snp_report_req
+:Returns (out): struct snp_report_resp on success, -negative on error
+
+The SNP_GET_REPORT ioctl can be used to query the attestation report from the
+SEV-SNP firmware. The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command
+provided by the SEV-SNP firmware to query the attestation report.
+
+On success, the snp_report_resp.data will contains the report. The report
+contain the format described in the SEV-SNP specification. See the SEV-SNP
+specification for further details.
+
+2.2 SNP_GET_DERIVED_KEY
+-----------------------
+:Technology: sev-snp
+:Type: guest ioctl
+:Parameters (in): struct snp_derived_key_req
+:Returns (out): struct snp_derived_key_resp on success, -negative on error
+
+The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.
+The derived key can be used by the guest for any purpose, such as sealing keys
+or communicating with external entities.
+
+The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
+SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
+on the various fields passed in the key derivation request.
+
+On success, the snp_derived_key_resp.data contains the derived key value. See
+the SEV-SNP specification for further details.
+
+
+2.3 SNP_GET_EXT_REPORT
+----------------------
+:Technology: sev-snp
+:Type: guest ioctl
+:Parameters (in/out): struct snp_ext_report_req
+:Returns (out): struct snp_report_resp on success, -negative on error
+
+The SNP_GET_EXT_REPORT ioctl is similar to the SNP_GET_REPORT. The difference is
+related to the additional certificate data that is returned with the report.
+The certificate data returned is being provided by the hypervisor through the
+SNP_SET_EXT_CONFIG.
+
+The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command provided by the SEV-SNP
+firmware to get the attestation report.
+
+On success, the snp_ext_report_resp.data will contain the attestation report
+and snp_ext_report_req.certs_address will contain the certificate blob. If the
+length of the blob is smaller than expected then snp_ext_report_req.certs_len will
+be updated with the expected value.
+
+See GHCB specification for further detail on how to parse the certificate blob.
+
+3. SEV-SNP CPUID Enforcement
+============================
+
+SEV-SNP guests can access a special page that contains a table of CPUID values
+that have been validated by the PSP as part of the SNP_LAUNCH_UPDATE firmware
+command. It provides the following assurances regarding the validity of CPUID
+values:
+
+ - Its address is obtained via bootloader/firmware (via CC blob), and those
+   binaries will be measured as part of the SEV-SNP attestation report.
+ - Its initial state will be encrypted/pvalidated, so attempts to modify
+   it during run-time will result in garbage being written, or #VC exceptions
+   being generated due to changes in validation state if the hypervisor tries
+   to swap the backing page.
+ - Attempts to bypass PSP checks by the hypervisor by using a normal page, or
+   a non-CPUID encrypted page will change the measurement provided by the
+   SEV-SNP attestation report.
+ - The CPUID page contents are *not* measured, but attempts to modify the
+   expected contents of a CPUID page as part of guest initialization will be
+   gated by the PSP CPUID enforcement policy checks performed on the page
+   during SNP_LAUNCH_UPDATE, and noticeable later if the guest owner
+   implements their own checks of the CPUID values.
+
+It is important to note that this last assurance is only useful if the kernel
+has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
+Otherwise, guest owner attestation provides no assurance that the kernel wasn't
+fed incorrect values at some point during boot.
+
+
+Reference
+---------
+
+SEV-SNP and GHCB specification: developer.amd.com/sev
+
+The driver is based on SEV-SNP firmware spec 0.9 and GHCB spec version 2.0.
diff --git a/Documentation/virt/coco/sevguest.rst b/Documentation/virt/coco/sevguest.rst
deleted file mode 100644
index bf593e8..0000000
--- a/Documentation/virt/coco/sevguest.rst
+++ /dev/null
@@ -1,155 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-===================================================================
-The Definitive SEV Guest API Documentation
-===================================================================
-
-1. General description
-======================
-
-The SEV API is a set of ioctls that are used by the guest or hypervisor
-to get or set a certain aspect of the SEV virtual machine. The ioctls belong
-to the following classes:
-
- - Hypervisor ioctls: These query and set global attributes which affect the
-   whole SEV firmware.  These ioctl are used by platform provisioning tools.
-
- - Guest ioctls: These query and set attributes of the SEV virtual machine.
-
-2. API description
-==================
-
-This section describes ioctls that is used for querying the SEV guest report
-from the SEV firmware. For each ioctl, the following information is provided
-along with a description:
-
-  Technology:
-      which SEV technology provides this ioctl. SEV, SEV-ES, SEV-SNP or all.
-
-  Type:
-      hypervisor or guest. The ioctl can be used inside the guest or the
-      hypervisor.
-
-  Parameters:
-      what parameters are accepted by the ioctl.
-
-  Returns:
-      the return value.  General error numbers (-ENOMEM, -EINVAL)
-      are not detailed, but errors with specific meanings are.
-
-The guest ioctl should be issued on a file descriptor of the /dev/sev-guest device.
-The ioctl accepts struct snp_user_guest_request. The input and output structure is
-specified through the req_data and resp_data field respectively. If the ioctl fails
-to execute due to a firmware error, then fw_err code will be set otherwise the
-fw_err will be set to 0x00000000000000ff.
-
-The firmware checks that the message sequence counter is one greater than
-the guests message sequence counter. If guest driver fails to increment message
-counter (e.g. counter overflow), then -EIO will be returned.
-
-::
-
-        struct snp_guest_request_ioctl {
-                /* Message version number */
-                __u32 msg_version;
-
-                /* Request and response structure address */
-                __u64 req_data;
-                __u64 resp_data;
-
-                /* firmware error code on failure (see psp-sev.h) */
-                __u64 fw_err;
-        };
-
-2.1 SNP_GET_REPORT
-------------------
-
-:Technology: sev-snp
-:Type: guest ioctl
-:Parameters (in): struct snp_report_req
-:Returns (out): struct snp_report_resp on success, -negative on error
-
-The SNP_GET_REPORT ioctl can be used to query the attestation report from the
-SEV-SNP firmware. The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command
-provided by the SEV-SNP firmware to query the attestation report.
-
-On success, the snp_report_resp.data will contains the report. The report
-contain the format described in the SEV-SNP specification. See the SEV-SNP
-specification for further details.
-
-2.2 SNP_GET_DERIVED_KEY
------------------------
-:Technology: sev-snp
-:Type: guest ioctl
-:Parameters (in): struct snp_derived_key_req
-:Returns (out): struct snp_derived_key_resp on success, -negative on error
-
-The SNP_GET_DERIVED_KEY ioctl can be used to get a key derive from a root key.
-The derived key can be used by the guest for any purpose, such as sealing keys
-or communicating with external entities.
-
-The ioctl uses the SNP_GUEST_REQUEST (MSG_KEY_REQ) command provided by the
-SEV-SNP firmware to derive the key. See SEV-SNP specification for further details
-on the various fields passed in the key derivation request.
-
-On success, the snp_derived_key_resp.data contains the derived key value. See
-the SEV-SNP specification for further details.
-
-
-2.3 SNP_GET_EXT_REPORT
-----------------------
-:Technology: sev-snp
-:Type: guest ioctl
-:Parameters (in/out): struct snp_ext_report_req
-:Returns (out): struct snp_report_resp on success, -negative on error
-
-The SNP_GET_EXT_REPORT ioctl is similar to the SNP_GET_REPORT. The difference is
-related to the additional certificate data that is returned with the report.
-The certificate data returned is being provided by the hypervisor through the
-SNP_SET_EXT_CONFIG.
-
-The ioctl uses the SNP_GUEST_REQUEST (MSG_REPORT_REQ) command provided by the SEV-SNP
-firmware to get the attestation report.
-
-On success, the snp_ext_report_resp.data will contain the attestation report
-and snp_ext_report_req.certs_address will contain the certificate blob. If the
-length of the blob is smaller than expected then snp_ext_report_req.certs_len will
-be updated with the expected value.
-
-See GHCB specification for further detail on how to parse the certificate blob.
-
-3. SEV-SNP CPUID Enforcement
-============================
-
-SEV-SNP guests can access a special page that contains a table of CPUID values
-that have been validated by the PSP as part of the SNP_LAUNCH_UPDATE firmware
-command. It provides the following assurances regarding the validity of CPUID
-values:
-
- - Its address is obtained via bootloader/firmware (via CC blob), and those
-   binaries will be measured as part of the SEV-SNP attestation report.
- - Its initial state will be encrypted/pvalidated, so attempts to modify
-   it during run-time will result in garbage being written, or #VC exceptions
-   being generated due to changes in validation state if the hypervisor tries
-   to swap the backing page.
- - Attempts to bypass PSP checks by the hypervisor by using a normal page, or
-   a non-CPUID encrypted page will change the measurement provided by the
-   SEV-SNP attestation report.
- - The CPUID page contents are *not* measured, but attempts to modify the
-   expected contents of a CPUID page as part of guest initialization will be
-   gated by the PSP CPUID enforcement policy checks performed on the page
-   during SNP_LAUNCH_UPDATE, and noticeable later if the guest owner
-   implements their own checks of the CPUID values.
-
-It is important to note that this last assurance is only useful if the kernel
-has taken care to make use of the SEV-SNP CPUID throughout all stages of boot.
-Otherwise, guest owner attestation provides no assurance that the kernel wasn't
-fed incorrect values at some point during boot.
-
-
-Reference
----------
-
-SEV-SNP and GHCB specification: developer.amd.com/sev
-
-The driver is based on SEV-SNP firmware spec 0.9 and GHCB spec version 2.0.
diff --git a/Documentation/virt/index.rst b/Documentation/virt/index.rst
index 40ad0d2..492f092 100644
--- a/Documentation/virt/index.rst
+++ b/Documentation/virt/index.rst
@@ -13,7 +13,7 @@ Linux Virtualization Support
    guest-halt-polling
    ne_overview
    acrn/index
-   coco/sevguest
+   coco/sev-guest
 
 .. only:: html and subproject
 
diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 7d3273c..0c1bba7 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -48,6 +48,6 @@ source "drivers/virt/nitro_enclaves/Kconfig"
 
 source "drivers/virt/acrn/Kconfig"
 
-source "drivers/virt/coco/sevguest/Kconfig"
+source "drivers/virt/coco/sev-guest/Kconfig"
 
 endif
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 7b87a7b..b2e6e86 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -9,4 +9,4 @@ obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
 obj-$(CONFIG_ACRN_HSM)		+= acrn/
-obj-$(CONFIG_SEV_GUEST)		+= coco/sevguest/
+obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
diff --git a/drivers/virt/coco/sev-guest/Kconfig b/drivers/virt/coco/sev-guest/Kconfig
new file mode 100644
index 0000000..f9db079
--- /dev/null
+++ b/drivers/virt/coco/sev-guest/Kconfig
@@ -0,0 +1,14 @@
+config SEV_GUEST
+	tristate "AMD SEV Guest driver"
+	default m
+	depends on AMD_MEM_ENCRYPT
+	select CRYPTO_AEAD2
+	select CRYPTO_GCM
+	help
+	  SEV-SNP firmware provides the guest a mechanism to communicate with
+	  the PSP without risk from a malicious hypervisor who wishes to read,
+	  alter, drop or replay the messages sent. The driver provides
+	  userspace interface to communicate with the PSP to request the
+	  attestation report and more.
+
+	  If you choose 'M' here, this module will be called sev-guest.
diff --git a/drivers/virt/coco/sev-guest/Makefile b/drivers/virt/coco/sev-guest/Makefile
new file mode 100644
index 0000000..63d67c2
--- /dev/null
+++ b/drivers/virt/coco/sev-guest/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_SEV_GUEST) += sev-guest.o
diff --git a/drivers/virt/coco/sev-guest/sev-guest.c b/drivers/virt/coco/sev-guest/sev-guest.c
new file mode 100644
index 0000000..90ce16b
--- /dev/null
+++ b/drivers/virt/coco/sev-guest/sev-guest.c
@@ -0,0 +1,743 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Secure Encrypted Virtualization (SEV) guest driver interface
+ *
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/mutex.h>
+#include <linux/io.h>
+#include <linux/platform_device.h>
+#include <linux/miscdevice.h>
+#include <linux/set_memory.h>
+#include <linux/fs.h>
+#include <crypto/aead.h>
+#include <linux/scatterlist.h>
+#include <linux/psp-sev.h>
+#include <uapi/linux/sev-guest.h>
+#include <uapi/linux/psp-sev.h>
+
+#include <asm/svm.h>
+#include <asm/sev.h>
+
+#include "sev-guest.h"
+
+#define DEVICE_NAME	"sev-guest"
+#define AAD_LEN		48
+#define MSG_HDR_VER	1
+
+struct snp_guest_crypto {
+	struct crypto_aead *tfm;
+	u8 *iv, *authtag;
+	int iv_len, a_len;
+};
+
+struct snp_guest_dev {
+	struct device *dev;
+	struct miscdevice misc;
+
+	void *certs_data;
+	struct snp_guest_crypto *crypto;
+	struct snp_guest_msg *request, *response;
+	struct snp_secrets_page_layout *layout;
+	struct snp_req_data input;
+	u32 *os_area_msg_seqno;
+	u8 *vmpck;
+};
+
+static u32 vmpck_id;
+module_param(vmpck_id, uint, 0444);
+MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
+
+/* Mutex to serialize the shared buffer access and command handling. */
+static DEFINE_MUTEX(snp_cmd_mutex);
+
+static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
+{
+	char zero_key[VMPCK_KEY_LEN] = {0};
+
+	if (snp_dev->vmpck)
+		return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
+
+	return true;
+}
+
+static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
+{
+	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
+	snp_dev->vmpck = NULL;
+}
+
+static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
+{
+	u64 count;
+
+	lockdep_assert_held(&snp_cmd_mutex);
+
+	/* Read the current message sequence counter from secrets pages */
+	count = *snp_dev->os_area_msg_seqno;
+
+	return count + 1;
+}
+
+/* Return a non-zero on success */
+static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
+{
+	u64 count = __snp_get_msg_seqno(snp_dev);
+
+	/*
+	 * The message sequence counter for the SNP guest request is a  64-bit
+	 * value but the version 2 of GHCB specification defines a 32-bit storage
+	 * for it. If the counter exceeds the 32-bit value then return zero.
+	 * The caller should check the return value, but if the caller happens to
+	 * not check the value and use it, then the firmware treats zero as an
+	 * invalid number and will fail the  message request.
+	 */
+	if (count >= UINT_MAX) {
+		dev_err(snp_dev->dev, "request message sequence counter overflow\n");
+		return 0;
+	}
+
+	return count;
+}
+
+static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
+{
+	/*
+	 * The counter is also incremented by the PSP, so increment it by 2
+	 * and save in secrets page.
+	 */
+	*snp_dev->os_area_msg_seqno += 2;
+}
+
+static inline struct snp_guest_dev *to_snp_dev(struct file *file)
+{
+	struct miscdevice *dev = file->private_data;
+
+	return container_of(dev, struct snp_guest_dev, misc);
+}
+
+static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
+{
+	struct snp_guest_crypto *crypto;
+
+	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
+	if (!crypto)
+		return NULL;
+
+	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
+	if (IS_ERR(crypto->tfm))
+		goto e_free;
+
+	if (crypto_aead_setkey(crypto->tfm, key, keylen))
+		goto e_free_crypto;
+
+	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
+	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
+	if (!crypto->iv)
+		goto e_free_crypto;
+
+	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
+		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
+			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
+			goto e_free_iv;
+		}
+	}
+
+	crypto->a_len = crypto_aead_authsize(crypto->tfm);
+	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
+	if (!crypto->authtag)
+		goto e_free_auth;
+
+	return crypto;
+
+e_free_auth:
+	kfree(crypto->authtag);
+e_free_iv:
+	kfree(crypto->iv);
+e_free_crypto:
+	crypto_free_aead(crypto->tfm);
+e_free:
+	kfree(crypto);
+
+	return NULL;
+}
+
+static void deinit_crypto(struct snp_guest_crypto *crypto)
+{
+	crypto_free_aead(crypto->tfm);
+	kfree(crypto->iv);
+	kfree(crypto->authtag);
+	kfree(crypto);
+}
+
+static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
+			   u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
+{
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+	struct scatterlist src[3], dst[3];
+	DECLARE_CRYPTO_WAIT(wait);
+	struct aead_request *req;
+	int ret;
+
+	req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+
+	/*
+	 * AEAD memory operations:
+	 * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
+	 * |  msg header      |  plaintext       |  hdr->authtag  |
+	 * | bytes 30h - 5Fh  |    or            |                |
+	 * |                  |   cipher         |                |
+	 * +------------------+------------------+----------------+
+	 */
+	sg_init_table(src, 3);
+	sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
+	sg_set_buf(&src[1], src_buf, hdr->msg_sz);
+	sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
+
+	sg_init_table(dst, 3);
+	sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
+	sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
+	sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
+
+	aead_request_set_ad(req, AAD_LEN);
+	aead_request_set_tfm(req, crypto->tfm);
+	aead_request_set_callback(req, 0, crypto_req_done, &wait);
+
+	aead_request_set_crypt(req, src, dst, len, crypto->iv);
+	ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
+
+	aead_request_free(req);
+	return ret;
+}
+
+static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+			 void *plaintext, size_t len)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+
+	memset(crypto->iv, 0, crypto->iv_len);
+	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+
+	return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
+}
+
+static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
+		       void *plaintext, size_t len)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_guest_msg_hdr *hdr = &msg->hdr;
+
+	/* Build IV with response buffer sequence number */
+	memset(crypto->iv, 0, crypto->iv_len);
+	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
+
+	return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
+}
+
+static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_guest_msg *resp = snp_dev->response;
+	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
+	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
+
+	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
+		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
+
+	/* Verify that the sequence counter is incremented by 1 */
+	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
+		return -EBADMSG;
+
+	/* Verify response message type and version number. */
+	if (resp_hdr->msg_type != (req_hdr->msg_type + 1) ||
+	    resp_hdr->msg_version != req_hdr->msg_version)
+		return -EBADMSG;
+
+	/*
+	 * If the message size is greater than our buffer length then return
+	 * an error.
+	 */
+	if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
+		return -EBADMSG;
+
+	/* Decrypt the payload */
+	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
+}
+
+static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
+			void *payload, size_t sz)
+{
+	struct snp_guest_msg *req = snp_dev->request;
+	struct snp_guest_msg_hdr *hdr = &req->hdr;
+
+	memset(req, 0, sizeof(*req));
+
+	hdr->algo = SNP_AEAD_AES_256_GCM;
+	hdr->hdr_version = MSG_HDR_VER;
+	hdr->hdr_sz = sizeof(*hdr);
+	hdr->msg_type = type;
+	hdr->msg_version = version;
+	hdr->msg_seqno = seqno;
+	hdr->msg_vmpck = vmpck_id;
+	hdr->msg_sz = sz;
+
+	/* Verify the sequence number is non-zero */
+	if (!hdr->msg_seqno)
+		return -ENOSR;
+
+	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
+		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
+
+	return __enc_payload(snp_dev, req, payload, sz);
+}
+
+static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
+				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
+				u32 resp_sz, __u64 *fw_err)
+{
+	unsigned long err;
+	u64 seqno;
+	int rc;
+
+	/* Get message sequence and verify that its a non-zero */
+	seqno = snp_get_msg_seqno(snp_dev);
+	if (!seqno)
+		return -EIO;
+
+	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
+
+	/* Encrypt the userspace provided payload */
+	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
+	if (rc)
+		return rc;
+
+	/* Call firmware to process the request */
+	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
+	if (fw_err)
+		*fw_err = err;
+
+	if (rc)
+		return rc;
+
+	/*
+	 * The verify_and_dec_payload() will fail only if the hypervisor is
+	 * actively modifying the message header or corrupting the encrypted payload.
+	 * This hints that hypervisor is acting in a bad faith. Disable the VMPCK so that
+	 * the key cannot be used for any communication. The key is disabled to ensure
+	 * that AES-GCM does not use the same IV while encrypting the request payload.
+	 */
+	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
+	if (rc) {
+		dev_alert(snp_dev->dev,
+			  "Detected unexpected decode failure, disabling the vmpck_id %d\n",
+			  vmpck_id);
+		snp_disable_vmpck(snp_dev);
+		return rc;
+	}
+
+	/* Increment to new message sequence after payload decryption was successful. */
+	snp_inc_msg_seqno(snp_dev);
+
+	return 0;
+}
+
+static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_report_resp *resp;
+	struct snp_report_req req;
+	int rc, resp_len;
+
+	lockdep_assert_held(&snp_cmd_mutex);
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
+
+	/*
+	 * The intermediate response buffer is used while decrypting the
+	 * response payload. Make sure that it has enough space to cover the
+	 * authtag.
+	 */
+	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!resp)
+		return -ENOMEM;
+
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
+				  resp_len, &arg->fw_err);
+	if (rc)
+		goto e_free;
+
+	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+		rc = -EFAULT;
+
+e_free:
+	kfree(resp);
+	return rc;
+}
+
+static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_derived_key_resp resp = {0};
+	struct snp_derived_key_req req;
+	int rc, resp_len;
+	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
+	u8 buf[64 + 16];
+
+	lockdep_assert_held(&snp_cmd_mutex);
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	/*
+	 * The intermediate response buffer is used while decrypting the
+	 * response payload. Make sure that it has enough space to cover the
+	 * authtag.
+	 */
+	resp_len = sizeof(resp.data) + crypto->a_len;
+	if (sizeof(buf) < resp_len)
+		return -ENOMEM;
+
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
+
+	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
+				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
+				  &arg->fw_err);
+	if (rc)
+		return rc;
+
+	memcpy(resp.data, buf, sizeof(resp.data));
+	if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
+		rc = -EFAULT;
+
+	/* The response buffer contains the sensitive data, explicitly clear it. */
+	memzero_explicit(buf, sizeof(buf));
+	memzero_explicit(&resp, sizeof(resp));
+	return rc;
+}
+
+static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
+{
+	struct snp_guest_crypto *crypto = snp_dev->crypto;
+	struct snp_ext_report_req req;
+	struct snp_report_resp *resp;
+	int ret, npages = 0, resp_len;
+
+	lockdep_assert_held(&snp_cmd_mutex);
+
+	if (!arg->req_data || !arg->resp_data)
+		return -EINVAL;
+
+	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
+		return -EFAULT;
+
+	/* userspace does not want certificate data */
+	if (!req.certs_len || !req.certs_address)
+		goto cmd;
+
+	if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
+	    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
+		return -EINVAL;
+
+	if (!access_ok((const void __user *)req.certs_address, req.certs_len))
+		return -EFAULT;
+
+	/*
+	 * Initialize the intermediate buffer with all zeros. This buffer
+	 * is used in the guest request message to get the certs blob from
+	 * the host. If host does not supply any certs in it, then copy
+	 * zeros to indicate that certificate data was not provided.
+	 */
+	memset(snp_dev->certs_data, 0, req.certs_len);
+	npages = req.certs_len >> PAGE_SHIFT;
+cmd:
+	/*
+	 * The intermediate response buffer is used while decrypting the
+	 * response payload. Make sure that it has enough space to cover the
+	 * authtag.
+	 */
+	resp_len = sizeof(resp->data) + crypto->a_len;
+	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
+	if (!resp)
+		return -ENOMEM;
+
+	snp_dev->input.data_npages = npages;
+	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
+				   SNP_MSG_REPORT_REQ, &req.data,
+				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
+
+	/* If certs length is invalid then copy the returned length */
+	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
+		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
+
+		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
+			ret = -EFAULT;
+	}
+
+	if (ret)
+		goto e_free;
+
+	if (npages &&
+	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
+			 req.certs_len)) {
+		ret = -EFAULT;
+		goto e_free;
+	}
+
+	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
+		ret = -EFAULT;
+
+e_free:
+	kfree(resp);
+	return ret;
+}
+
+static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
+{
+	struct snp_guest_dev *snp_dev = to_snp_dev(file);
+	void __user *argp = (void __user *)arg;
+	struct snp_guest_request_ioctl input;
+	int ret = -ENOTTY;
+
+	if (copy_from_user(&input, argp, sizeof(input)))
+		return -EFAULT;
+
+	input.fw_err = 0xff;
+
+	/* Message version must be non-zero */
+	if (!input.msg_version)
+		return -EINVAL;
+
+	mutex_lock(&snp_cmd_mutex);
+
+	/* Check if the VMPCK is not empty */
+	if (is_vmpck_empty(snp_dev)) {
+		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
+		mutex_unlock(&snp_cmd_mutex);
+		return -ENOTTY;
+	}
+
+	switch (ioctl) {
+	case SNP_GET_REPORT:
+		ret = get_report(snp_dev, &input);
+		break;
+	case SNP_GET_DERIVED_KEY:
+		ret = get_derived_key(snp_dev, &input);
+		break;
+	case SNP_GET_EXT_REPORT:
+		ret = get_ext_report(snp_dev, &input);
+		break;
+	default:
+		break;
+	}
+
+	mutex_unlock(&snp_cmd_mutex);
+
+	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
+		return -EFAULT;
+
+	return ret;
+}
+
+static void free_shared_pages(void *buf, size_t sz)
+{
+	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+	int ret;
+
+	if (!buf)
+		return;
+
+	ret = set_memory_encrypted((unsigned long)buf, npages);
+	if (ret) {
+		WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
+		return;
+	}
+
+	__free_pages(virt_to_page(buf), get_order(sz));
+}
+
+static void *alloc_shared_pages(struct device *dev, size_t sz)
+{
+	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
+	struct page *page;
+	int ret;
+
+	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(sz));
+	if (!page)
+		return NULL;
+
+	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
+	if (ret) {
+		dev_err(dev, "failed to mark page shared, ret=%d\n", ret);
+		__free_pages(page, get_order(sz));
+		return NULL;
+	}
+
+	return page_address(page);
+}
+
+static const struct file_operations snp_guest_fops = {
+	.owner	= THIS_MODULE,
+	.unlocked_ioctl = snp_guest_ioctl,
+};
+
+static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
+{
+	u8 *key = NULL;
+
+	switch (id) {
+	case 0:
+		*seqno = &layout->os_area.msg_seqno_0;
+		key = layout->vmpck0;
+		break;
+	case 1:
+		*seqno = &layout->os_area.msg_seqno_1;
+		key = layout->vmpck1;
+		break;
+	case 2:
+		*seqno = &layout->os_area.msg_seqno_2;
+		key = layout->vmpck2;
+		break;
+	case 3:
+		*seqno = &layout->os_area.msg_seqno_3;
+		key = layout->vmpck3;
+		break;
+	default:
+		break;
+	}
+
+	return key;
+}
+
+static int __init sev_guest_probe(struct platform_device *pdev)
+{
+	struct snp_secrets_page_layout *layout;
+	struct sev_guest_platform_data *data;
+	struct device *dev = &pdev->dev;
+	struct snp_guest_dev *snp_dev;
+	struct miscdevice *misc;
+	int ret;
+
+	if (!dev->platform_data)
+		return -ENODEV;
+
+	data = (struct sev_guest_platform_data *)dev->platform_data;
+	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
+	if (!layout)
+		return -ENODEV;
+
+	ret = -ENOMEM;
+	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
+	if (!snp_dev)
+		goto e_unmap;
+
+	ret = -EINVAL;
+	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
+	if (!snp_dev->vmpck) {
+		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
+		goto e_unmap;
+	}
+
+	/* Verify that VMPCK is not zero. */
+	if (is_vmpck_empty(snp_dev)) {
+		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
+		goto e_unmap;
+	}
+
+	platform_set_drvdata(pdev, snp_dev);
+	snp_dev->dev = dev;
+	snp_dev->layout = layout;
+
+	/* Allocate the shared page used for the request and response message. */
+	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
+	if (!snp_dev->request)
+		goto e_unmap;
+
+	snp_dev->response = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
+	if (!snp_dev->response)
+		goto e_free_request;
+
+	snp_dev->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
+	if (!snp_dev->certs_data)
+		goto e_free_response;
+
+	ret = -EIO;
+	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
+	if (!snp_dev->crypto)
+		goto e_free_cert_data;
+
+	misc = &snp_dev->misc;
+	misc->minor = MISC_DYNAMIC_MINOR;
+	misc->name = DEVICE_NAME;
+	misc->fops = &snp_guest_fops;
+
+	/* initial the input address for guest request */
+	snp_dev->input.req_gpa = __pa(snp_dev->request);
+	snp_dev->input.resp_gpa = __pa(snp_dev->response);
+	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
+
+	ret =  misc_register(misc);
+	if (ret)
+		goto e_free_cert_data;
+
+	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
+	return 0;
+
+e_free_cert_data:
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
+e_free_response:
+	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+e_free_request:
+	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
+e_unmap:
+	iounmap(layout);
+	return ret;
+}
+
+static int __exit sev_guest_remove(struct platform_device *pdev)
+{
+	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
+
+	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
+	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
+	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
+	deinit_crypto(snp_dev->crypto);
+	misc_deregister(&snp_dev->misc);
+
+	return 0;
+}
+
+/*
+ * This driver is meant to be a common SEV guest interface driver and to
+ * support any SEV guest API. As such, even though it has been introduced
+ * with the SEV-SNP support, it is named "sev-guest".
+ */
+static struct platform_driver sev_guest_driver = {
+	.remove		= __exit_p(sev_guest_remove),
+	.driver		= {
+		.name = "sev-guest",
+	},
+};
+
+module_platform_driver_probe(sev_guest_driver, sev_guest_probe);
+
+MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0.0");
+MODULE_DESCRIPTION("AMD SEV Guest Driver");
diff --git a/drivers/virt/coco/sev-guest/sev-guest.h b/drivers/virt/coco/sev-guest/sev-guest.h
new file mode 100644
index 0000000..d39bdd0
--- /dev/null
+++ b/drivers/virt/coco/sev-guest/sev-guest.h
@@ -0,0 +1,98 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2021 Advanced Micro Devices, Inc.
+ *
+ * Author: Brijesh Singh <brijesh.singh@amd.com>
+ *
+ * SEV-SNP API spec is available at https://developer.amd.com/sev
+ */
+
+#ifndef __VIRT_SEVGUEST_H__
+#define __VIRT_SEVGUEST_H__
+
+#include <linux/types.h>
+
+#define MAX_AUTHTAG_LEN		32
+
+/* See SNP spec SNP_GUEST_REQUEST section for the structure */
+enum msg_type {
+	SNP_MSG_TYPE_INVALID = 0,
+	SNP_MSG_CPUID_REQ,
+	SNP_MSG_CPUID_RSP,
+	SNP_MSG_KEY_REQ,
+	SNP_MSG_KEY_RSP,
+	SNP_MSG_REPORT_REQ,
+	SNP_MSG_REPORT_RSP,
+	SNP_MSG_EXPORT_REQ,
+	SNP_MSG_EXPORT_RSP,
+	SNP_MSG_IMPORT_REQ,
+	SNP_MSG_IMPORT_RSP,
+	SNP_MSG_ABSORB_REQ,
+	SNP_MSG_ABSORB_RSP,
+	SNP_MSG_VMRK_REQ,
+	SNP_MSG_VMRK_RSP,
+
+	SNP_MSG_TYPE_MAX
+};
+
+enum aead_algo {
+	SNP_AEAD_INVALID,
+	SNP_AEAD_AES_256_GCM,
+};
+
+struct snp_guest_msg_hdr {
+	u8 authtag[MAX_AUTHTAG_LEN];
+	u64 msg_seqno;
+	u8 rsvd1[8];
+	u8 algo;
+	u8 hdr_version;
+	u16 hdr_sz;
+	u8 msg_type;
+	u8 msg_version;
+	u16 msg_sz;
+	u32 rsvd2;
+	u8 msg_vmpck;
+	u8 rsvd3[35];
+} __packed;
+
+struct snp_guest_msg {
+	struct snp_guest_msg_hdr hdr;
+	u8 payload[4000];
+} __packed;
+
+/*
+ * The secrets page contains 96-bytes of reserved field that can be used by
+ * the guest OS. The guest OS uses the area to save the message sequence
+ * number for each VMPCK.
+ *
+ * See the GHCB spec section Secret page layout for the format for this area.
+ */
+struct secrets_os_area {
+	u32 msg_seqno_0;
+	u32 msg_seqno_1;
+	u32 msg_seqno_2;
+	u32 msg_seqno_3;
+	u64 ap_jump_table_pa;
+	u8 rsvd[40];
+	u8 guest_usage[32];
+} __packed;
+
+#define VMPCK_KEY_LEN		32
+
+/* See the SNP spec version 0.9 for secrets page format */
+struct snp_secrets_page_layout {
+	u32 version;
+	u32 imien	: 1,
+	    rsvd1	: 31;
+	u32 fms;
+	u32 rsvd2;
+	u8 gosvw[16];
+	u8 vmpck0[VMPCK_KEY_LEN];
+	u8 vmpck1[VMPCK_KEY_LEN];
+	u8 vmpck2[VMPCK_KEY_LEN];
+	u8 vmpck3[VMPCK_KEY_LEN];
+	struct secrets_os_area os_area;
+	u8 rsvd3[3840];
+} __packed;
+
+#endif /* __VIRT_SEVGUEST_H__ */
diff --git a/drivers/virt/coco/sevguest/Kconfig b/drivers/virt/coco/sevguest/Kconfig
deleted file mode 100644
index 74ca1fe..0000000
--- a/drivers/virt/coco/sevguest/Kconfig
+++ /dev/null
@@ -1,14 +0,0 @@
-config SEV_GUEST
-	tristate "AMD SEV Guest driver"
-	default m
-	depends on AMD_MEM_ENCRYPT
-	select CRYPTO_AEAD2
-	select CRYPTO_GCM
-	help
-	  SEV-SNP firmware provides the guest a mechanism to communicate with
-	  the PSP without risk from a malicious hypervisor who wishes to read,
-	  alter, drop or replay the messages sent. The driver provides
-	  userspace interface to communicate with the PSP to request the
-	  attestation report and more.
-
-	  If you choose 'M' here, this module will be called sevguest.
diff --git a/drivers/virt/coco/sevguest/Makefile b/drivers/virt/coco/sevguest/Makefile
deleted file mode 100644
index b1ffb2b..0000000
--- a/drivers/virt/coco/sevguest/Makefile
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_SEV_GUEST) += sevguest.o
diff --git a/drivers/virt/coco/sevguest/sevguest.c b/drivers/virt/coco/sevguest/sevguest.c
deleted file mode 100644
index 18c3231..0000000
--- a/drivers/virt/coco/sevguest/sevguest.c
+++ /dev/null
@@ -1,743 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * AMD Secure Encrypted Virtualization (SEV) guest driver interface
- *
- * Copyright (C) 2021 Advanced Micro Devices, Inc.
- *
- * Author: Brijesh Singh <brijesh.singh@amd.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/types.h>
-#include <linux/mutex.h>
-#include <linux/io.h>
-#include <linux/platform_device.h>
-#include <linux/miscdevice.h>
-#include <linux/set_memory.h>
-#include <linux/fs.h>
-#include <crypto/aead.h>
-#include <linux/scatterlist.h>
-#include <linux/psp-sev.h>
-#include <uapi/linux/sev-guest.h>
-#include <uapi/linux/psp-sev.h>
-
-#include <asm/svm.h>
-#include <asm/sev.h>
-
-#include "sevguest.h"
-
-#define DEVICE_NAME	"sev-guest"
-#define AAD_LEN		48
-#define MSG_HDR_VER	1
-
-struct snp_guest_crypto {
-	struct crypto_aead *tfm;
-	u8 *iv, *authtag;
-	int iv_len, a_len;
-};
-
-struct snp_guest_dev {
-	struct device *dev;
-	struct miscdevice misc;
-
-	void *certs_data;
-	struct snp_guest_crypto *crypto;
-	struct snp_guest_msg *request, *response;
-	struct snp_secrets_page_layout *layout;
-	struct snp_req_data input;
-	u32 *os_area_msg_seqno;
-	u8 *vmpck;
-};
-
-static u32 vmpck_id;
-module_param(vmpck_id, uint, 0444);
-MODULE_PARM_DESC(vmpck_id, "The VMPCK ID to use when communicating with the PSP.");
-
-/* Mutex to serialize the shared buffer access and command handling. */
-static DEFINE_MUTEX(snp_cmd_mutex);
-
-static bool is_vmpck_empty(struct snp_guest_dev *snp_dev)
-{
-	char zero_key[VMPCK_KEY_LEN] = {0};
-
-	if (snp_dev->vmpck)
-		return !memcmp(snp_dev->vmpck, zero_key, VMPCK_KEY_LEN);
-
-	return true;
-}
-
-static void snp_disable_vmpck(struct snp_guest_dev *snp_dev)
-{
-	memzero_explicit(snp_dev->vmpck, VMPCK_KEY_LEN);
-	snp_dev->vmpck = NULL;
-}
-
-static inline u64 __snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
-{
-	u64 count;
-
-	lockdep_assert_held(&snp_cmd_mutex);
-
-	/* Read the current message sequence counter from secrets pages */
-	count = *snp_dev->os_area_msg_seqno;
-
-	return count + 1;
-}
-
-/* Return a non-zero on success */
-static u64 snp_get_msg_seqno(struct snp_guest_dev *snp_dev)
-{
-	u64 count = __snp_get_msg_seqno(snp_dev);
-
-	/*
-	 * The message sequence counter for the SNP guest request is a  64-bit
-	 * value but the version 2 of GHCB specification defines a 32-bit storage
-	 * for it. If the counter exceeds the 32-bit value then return zero.
-	 * The caller should check the return value, but if the caller happens to
-	 * not check the value and use it, then the firmware treats zero as an
-	 * invalid number and will fail the  message request.
-	 */
-	if (count >= UINT_MAX) {
-		dev_err(snp_dev->dev, "request message sequence counter overflow\n");
-		return 0;
-	}
-
-	return count;
-}
-
-static void snp_inc_msg_seqno(struct snp_guest_dev *snp_dev)
-{
-	/*
-	 * The counter is also incremented by the PSP, so increment it by 2
-	 * and save in secrets page.
-	 */
-	*snp_dev->os_area_msg_seqno += 2;
-}
-
-static inline struct snp_guest_dev *to_snp_dev(struct file *file)
-{
-	struct miscdevice *dev = file->private_data;
-
-	return container_of(dev, struct snp_guest_dev, misc);
-}
-
-static struct snp_guest_crypto *init_crypto(struct snp_guest_dev *snp_dev, u8 *key, size_t keylen)
-{
-	struct snp_guest_crypto *crypto;
-
-	crypto = kzalloc(sizeof(*crypto), GFP_KERNEL_ACCOUNT);
-	if (!crypto)
-		return NULL;
-
-	crypto->tfm = crypto_alloc_aead("gcm(aes)", 0, 0);
-	if (IS_ERR(crypto->tfm))
-		goto e_free;
-
-	if (crypto_aead_setkey(crypto->tfm, key, keylen))
-		goto e_free_crypto;
-
-	crypto->iv_len = crypto_aead_ivsize(crypto->tfm);
-	crypto->iv = kmalloc(crypto->iv_len, GFP_KERNEL_ACCOUNT);
-	if (!crypto->iv)
-		goto e_free_crypto;
-
-	if (crypto_aead_authsize(crypto->tfm) > MAX_AUTHTAG_LEN) {
-		if (crypto_aead_setauthsize(crypto->tfm, MAX_AUTHTAG_LEN)) {
-			dev_err(snp_dev->dev, "failed to set authsize to %d\n", MAX_AUTHTAG_LEN);
-			goto e_free_iv;
-		}
-	}
-
-	crypto->a_len = crypto_aead_authsize(crypto->tfm);
-	crypto->authtag = kmalloc(crypto->a_len, GFP_KERNEL_ACCOUNT);
-	if (!crypto->authtag)
-		goto e_free_auth;
-
-	return crypto;
-
-e_free_auth:
-	kfree(crypto->authtag);
-e_free_iv:
-	kfree(crypto->iv);
-e_free_crypto:
-	crypto_free_aead(crypto->tfm);
-e_free:
-	kfree(crypto);
-
-	return NULL;
-}
-
-static void deinit_crypto(struct snp_guest_crypto *crypto)
-{
-	crypto_free_aead(crypto->tfm);
-	kfree(crypto->iv);
-	kfree(crypto->authtag);
-	kfree(crypto);
-}
-
-static int enc_dec_message(struct snp_guest_crypto *crypto, struct snp_guest_msg *msg,
-			   u8 *src_buf, u8 *dst_buf, size_t len, bool enc)
-{
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-	struct scatterlist src[3], dst[3];
-	DECLARE_CRYPTO_WAIT(wait);
-	struct aead_request *req;
-	int ret;
-
-	req = aead_request_alloc(crypto->tfm, GFP_KERNEL);
-	if (!req)
-		return -ENOMEM;
-
-	/*
-	 * AEAD memory operations:
-	 * +------ AAD -------+------- DATA -----+---- AUTHTAG----+
-	 * |  msg header      |  plaintext       |  hdr->authtag  |
-	 * | bytes 30h - 5Fh  |    or            |                |
-	 * |                  |   cipher         |                |
-	 * +------------------+------------------+----------------+
-	 */
-	sg_init_table(src, 3);
-	sg_set_buf(&src[0], &hdr->algo, AAD_LEN);
-	sg_set_buf(&src[1], src_buf, hdr->msg_sz);
-	sg_set_buf(&src[2], hdr->authtag, crypto->a_len);
-
-	sg_init_table(dst, 3);
-	sg_set_buf(&dst[0], &hdr->algo, AAD_LEN);
-	sg_set_buf(&dst[1], dst_buf, hdr->msg_sz);
-	sg_set_buf(&dst[2], hdr->authtag, crypto->a_len);
-
-	aead_request_set_ad(req, AAD_LEN);
-	aead_request_set_tfm(req, crypto->tfm);
-	aead_request_set_callback(req, 0, crypto_req_done, &wait);
-
-	aead_request_set_crypt(req, src, dst, len, crypto->iv);
-	ret = crypto_wait_req(enc ? crypto_aead_encrypt(req) : crypto_aead_decrypt(req), &wait);
-
-	aead_request_free(req);
-	return ret;
-}
-
-static int __enc_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
-			 void *plaintext, size_t len)
-{
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-
-	memset(crypto->iv, 0, crypto->iv_len);
-	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
-
-	return enc_dec_message(crypto, msg, plaintext, msg->payload, len, true);
-}
-
-static int dec_payload(struct snp_guest_dev *snp_dev, struct snp_guest_msg *msg,
-		       void *plaintext, size_t len)
-{
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg_hdr *hdr = &msg->hdr;
-
-	/* Build IV with response buffer sequence number */
-	memset(crypto->iv, 0, crypto->iv_len);
-	memcpy(crypto->iv, &hdr->msg_seqno, sizeof(hdr->msg_seqno));
-
-	return enc_dec_message(crypto, msg, msg->payload, plaintext, len, false);
-}
-
-static int verify_and_dec_payload(struct snp_guest_dev *snp_dev, void *payload, u32 sz)
-{
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_guest_msg *resp = snp_dev->response;
-	struct snp_guest_msg *req = snp_dev->request;
-	struct snp_guest_msg_hdr *req_hdr = &req->hdr;
-	struct snp_guest_msg_hdr *resp_hdr = &resp->hdr;
-
-	dev_dbg(snp_dev->dev, "response [seqno %lld type %d version %d sz %d]\n",
-		resp_hdr->msg_seqno, resp_hdr->msg_type, resp_hdr->msg_version, resp_hdr->msg_sz);
-
-	/* Verify that the sequence counter is incremented by 1 */
-	if (unlikely(resp_hdr->msg_seqno != (req_hdr->msg_seqno + 1)))
-		return -EBADMSG;
-
-	/* Verify response message type and version number. */
-	if (resp_hdr->msg_type != (req_hdr->msg_type + 1) ||
-	    resp_hdr->msg_version != req_hdr->msg_version)
-		return -EBADMSG;
-
-	/*
-	 * If the message size is greater than our buffer length then return
-	 * an error.
-	 */
-	if (unlikely((resp_hdr->msg_sz + crypto->a_len) > sz))
-		return -EBADMSG;
-
-	/* Decrypt the payload */
-	return dec_payload(snp_dev, resp, payload, resp_hdr->msg_sz + crypto->a_len);
-}
-
-static int enc_payload(struct snp_guest_dev *snp_dev, u64 seqno, int version, u8 type,
-			void *payload, size_t sz)
-{
-	struct snp_guest_msg *req = snp_dev->request;
-	struct snp_guest_msg_hdr *hdr = &req->hdr;
-
-	memset(req, 0, sizeof(*req));
-
-	hdr->algo = SNP_AEAD_AES_256_GCM;
-	hdr->hdr_version = MSG_HDR_VER;
-	hdr->hdr_sz = sizeof(*hdr);
-	hdr->msg_type = type;
-	hdr->msg_version = version;
-	hdr->msg_seqno = seqno;
-	hdr->msg_vmpck = vmpck_id;
-	hdr->msg_sz = sz;
-
-	/* Verify the sequence number is non-zero */
-	if (!hdr->msg_seqno)
-		return -ENOSR;
-
-	dev_dbg(snp_dev->dev, "request [seqno %lld type %d version %d sz %d]\n",
-		hdr->msg_seqno, hdr->msg_type, hdr->msg_version, hdr->msg_sz);
-
-	return __enc_payload(snp_dev, req, payload, sz);
-}
-
-static int handle_guest_request(struct snp_guest_dev *snp_dev, u64 exit_code, int msg_ver,
-				u8 type, void *req_buf, size_t req_sz, void *resp_buf,
-				u32 resp_sz, __u64 *fw_err)
-{
-	unsigned long err;
-	u64 seqno;
-	int rc;
-
-	/* Get message sequence and verify that its a non-zero */
-	seqno = snp_get_msg_seqno(snp_dev);
-	if (!seqno)
-		return -EIO;
-
-	memset(snp_dev->response, 0, sizeof(struct snp_guest_msg));
-
-	/* Encrypt the userspace provided payload */
-	rc = enc_payload(snp_dev, seqno, msg_ver, type, req_buf, req_sz);
-	if (rc)
-		return rc;
-
-	/* Call firmware to process the request */
-	rc = snp_issue_guest_request(exit_code, &snp_dev->input, &err);
-	if (fw_err)
-		*fw_err = err;
-
-	if (rc)
-		return rc;
-
-	/*
-	 * The verify_and_dec_payload() will fail only if the hypervisor is
-	 * actively modifying the message header or corrupting the encrypted payload.
-	 * This hints that hypervisor is acting in a bad faith. Disable the VMPCK so that
-	 * the key cannot be used for any communication. The key is disabled to ensure
-	 * that AES-GCM does not use the same IV while encrypting the request payload.
-	 */
-	rc = verify_and_dec_payload(snp_dev, resp_buf, resp_sz);
-	if (rc) {
-		dev_alert(snp_dev->dev,
-			  "Detected unexpected decode failure, disabling the vmpck_id %d\n",
-			  vmpck_id);
-		snp_disable_vmpck(snp_dev);
-		return rc;
-	}
-
-	/* Increment to new message sequence after payload decryption was successful. */
-	snp_inc_msg_seqno(snp_dev);
-
-	return 0;
-}
-
-static int get_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
-{
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_report_resp *resp;
-	struct snp_report_req req;
-	int rc, resp_len;
-
-	lockdep_assert_held(&snp_cmd_mutex);
-
-	if (!arg->req_data || !arg->resp_data)
-		return -EINVAL;
-
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
-		return -EFAULT;
-
-	/*
-	 * The intermediate response buffer is used while decrypting the
-	 * response payload. Make sure that it has enough space to cover the
-	 * authtag.
-	 */
-	resp_len = sizeof(resp->data) + crypto->a_len;
-	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
-	if (!resp)
-		return -ENOMEM;
-
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_REPORT_REQ, &req, sizeof(req), resp->data,
-				  resp_len, &arg->fw_err);
-	if (rc)
-		goto e_free;
-
-	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
-		rc = -EFAULT;
-
-e_free:
-	kfree(resp);
-	return rc;
-}
-
-static int get_derived_key(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
-{
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_derived_key_resp resp = {0};
-	struct snp_derived_key_req req;
-	int rc, resp_len;
-	/* Response data is 64 bytes and max authsize for GCM is 16 bytes. */
-	u8 buf[64 + 16];
-
-	lockdep_assert_held(&snp_cmd_mutex);
-
-	if (!arg->req_data || !arg->resp_data)
-		return -EINVAL;
-
-	/*
-	 * The intermediate response buffer is used while decrypting the
-	 * response payload. Make sure that it has enough space to cover the
-	 * authtag.
-	 */
-	resp_len = sizeof(resp.data) + crypto->a_len;
-	if (sizeof(buf) < resp_len)
-		return -ENOMEM;
-
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
-		return -EFAULT;
-
-	rc = handle_guest_request(snp_dev, SVM_VMGEXIT_GUEST_REQUEST, arg->msg_version,
-				  SNP_MSG_KEY_REQ, &req, sizeof(req), buf, resp_len,
-				  &arg->fw_err);
-	if (rc)
-		return rc;
-
-	memcpy(resp.data, buf, sizeof(resp.data));
-	if (copy_to_user((void __user *)arg->resp_data, &resp, sizeof(resp)))
-		rc = -EFAULT;
-
-	/* The response buffer contains the sensitive data, explicitly clear it. */
-	memzero_explicit(buf, sizeof(buf));
-	memzero_explicit(&resp, sizeof(resp));
-	return rc;
-}
-
-static int get_ext_report(struct snp_guest_dev *snp_dev, struct snp_guest_request_ioctl *arg)
-{
-	struct snp_guest_crypto *crypto = snp_dev->crypto;
-	struct snp_ext_report_req req;
-	struct snp_report_resp *resp;
-	int ret, npages = 0, resp_len;
-
-	lockdep_assert_held(&snp_cmd_mutex);
-
-	if (!arg->req_data || !arg->resp_data)
-		return -EINVAL;
-
-	if (copy_from_user(&req, (void __user *)arg->req_data, sizeof(req)))
-		return -EFAULT;
-
-	/* userspace does not want certificate data */
-	if (!req.certs_len || !req.certs_address)
-		goto cmd;
-
-	if (req.certs_len > SEV_FW_BLOB_MAX_SIZE ||
-	    !IS_ALIGNED(req.certs_len, PAGE_SIZE))
-		return -EINVAL;
-
-	if (!access_ok((const void __user *)req.certs_address, req.certs_len))
-		return -EFAULT;
-
-	/*
-	 * Initialize the intermediate buffer with all zeros. This buffer
-	 * is used in the guest request message to get the certs blob from
-	 * the host. If host does not supply any certs in it, then copy
-	 * zeros to indicate that certificate data was not provided.
-	 */
-	memset(snp_dev->certs_data, 0, req.certs_len);
-	npages = req.certs_len >> PAGE_SHIFT;
-cmd:
-	/*
-	 * The intermediate response buffer is used while decrypting the
-	 * response payload. Make sure that it has enough space to cover the
-	 * authtag.
-	 */
-	resp_len = sizeof(resp->data) + crypto->a_len;
-	resp = kzalloc(resp_len, GFP_KERNEL_ACCOUNT);
-	if (!resp)
-		return -ENOMEM;
-
-	snp_dev->input.data_npages = npages;
-	ret = handle_guest_request(snp_dev, SVM_VMGEXIT_EXT_GUEST_REQUEST, arg->msg_version,
-				   SNP_MSG_REPORT_REQ, &req.data,
-				   sizeof(req.data), resp->data, resp_len, &arg->fw_err);
-
-	/* If certs length is invalid then copy the returned length */
-	if (arg->fw_err == SNP_GUEST_REQ_INVALID_LEN) {
-		req.certs_len = snp_dev->input.data_npages << PAGE_SHIFT;
-
-		if (copy_to_user((void __user *)arg->req_data, &req, sizeof(req)))
-			ret = -EFAULT;
-	}
-
-	if (ret)
-		goto e_free;
-
-	if (npages &&
-	    copy_to_user((void __user *)req.certs_address, snp_dev->certs_data,
-			 req.certs_len)) {
-		ret = -EFAULT;
-		goto e_free;
-	}
-
-	if (copy_to_user((void __user *)arg->resp_data, resp, sizeof(*resp)))
-		ret = -EFAULT;
-
-e_free:
-	kfree(resp);
-	return ret;
-}
-
-static long snp_guest_ioctl(struct file *file, unsigned int ioctl, unsigned long arg)
-{
-	struct snp_guest_dev *snp_dev = to_snp_dev(file);
-	void __user *argp = (void __user *)arg;
-	struct snp_guest_request_ioctl input;
-	int ret = -ENOTTY;
-
-	if (copy_from_user(&input, argp, sizeof(input)))
-		return -EFAULT;
-
-	input.fw_err = 0xff;
-
-	/* Message version must be non-zero */
-	if (!input.msg_version)
-		return -EINVAL;
-
-	mutex_lock(&snp_cmd_mutex);
-
-	/* Check if the VMPCK is not empty */
-	if (is_vmpck_empty(snp_dev)) {
-		dev_err_ratelimited(snp_dev->dev, "VMPCK is disabled\n");
-		mutex_unlock(&snp_cmd_mutex);
-		return -ENOTTY;
-	}
-
-	switch (ioctl) {
-	case SNP_GET_REPORT:
-		ret = get_report(snp_dev, &input);
-		break;
-	case SNP_GET_DERIVED_KEY:
-		ret = get_derived_key(snp_dev, &input);
-		break;
-	case SNP_GET_EXT_REPORT:
-		ret = get_ext_report(snp_dev, &input);
-		break;
-	default:
-		break;
-	}
-
-	mutex_unlock(&snp_cmd_mutex);
-
-	if (input.fw_err && copy_to_user(argp, &input, sizeof(input)))
-		return -EFAULT;
-
-	return ret;
-}
-
-static void free_shared_pages(void *buf, size_t sz)
-{
-	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
-	int ret;
-
-	if (!buf)
-		return;
-
-	ret = set_memory_encrypted((unsigned long)buf, npages);
-	if (ret) {
-		WARN_ONCE(ret, "failed to restore encryption mask (leak it)\n");
-		return;
-	}
-
-	__free_pages(virt_to_page(buf), get_order(sz));
-}
-
-static void *alloc_shared_pages(struct device *dev, size_t sz)
-{
-	unsigned int npages = PAGE_ALIGN(sz) >> PAGE_SHIFT;
-	struct page *page;
-	int ret;
-
-	page = alloc_pages(GFP_KERNEL_ACCOUNT, get_order(sz));
-	if (!page)
-		return NULL;
-
-	ret = set_memory_decrypted((unsigned long)page_address(page), npages);
-	if (ret) {
-		dev_err(dev, "failed to mark page shared, ret=%d\n", ret);
-		__free_pages(page, get_order(sz));
-		return NULL;
-	}
-
-	return page_address(page);
-}
-
-static const struct file_operations snp_guest_fops = {
-	.owner	= THIS_MODULE,
-	.unlocked_ioctl = snp_guest_ioctl,
-};
-
-static u8 *get_vmpck(int id, struct snp_secrets_page_layout *layout, u32 **seqno)
-{
-	u8 *key = NULL;
-
-	switch (id) {
-	case 0:
-		*seqno = &layout->os_area.msg_seqno_0;
-		key = layout->vmpck0;
-		break;
-	case 1:
-		*seqno = &layout->os_area.msg_seqno_1;
-		key = layout->vmpck1;
-		break;
-	case 2:
-		*seqno = &layout->os_area.msg_seqno_2;
-		key = layout->vmpck2;
-		break;
-	case 3:
-		*seqno = &layout->os_area.msg_seqno_3;
-		key = layout->vmpck3;
-		break;
-	default:
-		break;
-	}
-
-	return key;
-}
-
-static int __init sev_guest_probe(struct platform_device *pdev)
-{
-	struct snp_secrets_page_layout *layout;
-	struct sev_guest_platform_data *data;
-	struct device *dev = &pdev->dev;
-	struct snp_guest_dev *snp_dev;
-	struct miscdevice *misc;
-	int ret;
-
-	if (!dev->platform_data)
-		return -ENODEV;
-
-	data = (struct sev_guest_platform_data *)dev->platform_data;
-	layout = (__force void *)ioremap_encrypted(data->secrets_gpa, PAGE_SIZE);
-	if (!layout)
-		return -ENODEV;
-
-	ret = -ENOMEM;
-	snp_dev = devm_kzalloc(&pdev->dev, sizeof(struct snp_guest_dev), GFP_KERNEL);
-	if (!snp_dev)
-		goto e_unmap;
-
-	ret = -EINVAL;
-	snp_dev->vmpck = get_vmpck(vmpck_id, layout, &snp_dev->os_area_msg_seqno);
-	if (!snp_dev->vmpck) {
-		dev_err(dev, "invalid vmpck id %d\n", vmpck_id);
-		goto e_unmap;
-	}
-
-	/* Verify that VMPCK is not zero. */
-	if (is_vmpck_empty(snp_dev)) {
-		dev_err(dev, "vmpck id %d is null\n", vmpck_id);
-		goto e_unmap;
-	}
-
-	platform_set_drvdata(pdev, snp_dev);
-	snp_dev->dev = dev;
-	snp_dev->layout = layout;
-
-	/* Allocate the shared page used for the request and response message. */
-	snp_dev->request = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
-	if (!snp_dev->request)
-		goto e_unmap;
-
-	snp_dev->response = alloc_shared_pages(dev, sizeof(struct snp_guest_msg));
-	if (!snp_dev->response)
-		goto e_free_request;
-
-	snp_dev->certs_data = alloc_shared_pages(dev, SEV_FW_BLOB_MAX_SIZE);
-	if (!snp_dev->certs_data)
-		goto e_free_response;
-
-	ret = -EIO;
-	snp_dev->crypto = init_crypto(snp_dev, snp_dev->vmpck, VMPCK_KEY_LEN);
-	if (!snp_dev->crypto)
-		goto e_free_cert_data;
-
-	misc = &snp_dev->misc;
-	misc->minor = MISC_DYNAMIC_MINOR;
-	misc->name = DEVICE_NAME;
-	misc->fops = &snp_guest_fops;
-
-	/* initial the input address for guest request */
-	snp_dev->input.req_gpa = __pa(snp_dev->request);
-	snp_dev->input.resp_gpa = __pa(snp_dev->response);
-	snp_dev->input.data_gpa = __pa(snp_dev->certs_data);
-
-	ret =  misc_register(misc);
-	if (ret)
-		goto e_free_cert_data;
-
-	dev_info(dev, "Initialized SEV guest driver (using vmpck_id %d)\n", vmpck_id);
-	return 0;
-
-e_free_cert_data:
-	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
-e_free_response:
-	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
-e_free_request:
-	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
-e_unmap:
-	iounmap(layout);
-	return ret;
-}
-
-static int __exit sev_guest_remove(struct platform_device *pdev)
-{
-	struct snp_guest_dev *snp_dev = platform_get_drvdata(pdev);
-
-	free_shared_pages(snp_dev->certs_data, SEV_FW_BLOB_MAX_SIZE);
-	free_shared_pages(snp_dev->response, sizeof(struct snp_guest_msg));
-	free_shared_pages(snp_dev->request, sizeof(struct snp_guest_msg));
-	deinit_crypto(snp_dev->crypto);
-	misc_deregister(&snp_dev->misc);
-
-	return 0;
-}
-
-/*
- * This driver is a common SEV guest interface driver and meant to support
- * any SEV guest API. As such, even though it has been introduced along with
- * the SEV-SNP support, it is named "sev-guest".
- */
-static struct platform_driver sev_guest_driver = {
-	.remove		= __exit_p(sev_guest_remove),
-	.driver		= {
-		.name = "sev-guest",
-	},
-};
-
-module_platform_driver_probe(sev_guest_driver, sev_guest_probe);
-
-MODULE_AUTHOR("Brijesh Singh <brijesh.singh@amd.com>");
-MODULE_LICENSE("GPL");
-MODULE_VERSION("1.0.0");
-MODULE_DESCRIPTION("AMD SEV Guest Driver");
diff --git a/drivers/virt/coco/sevguest/sevguest.h b/drivers/virt/coco/sevguest/sevguest.h
deleted file mode 100644
index d39bdd0..0000000
--- a/drivers/virt/coco/sevguest/sevguest.h
+++ /dev/null
@@ -1,98 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2021 Advanced Micro Devices, Inc.
- *
- * Author: Brijesh Singh <brijesh.singh@amd.com>
- *
- * SEV-SNP API spec is available at https://developer.amd.com/sev
- */
-
-#ifndef __VIRT_SEVGUEST_H__
-#define __VIRT_SEVGUEST_H__
-
-#include <linux/types.h>
-
-#define MAX_AUTHTAG_LEN		32
-
-/* See SNP spec SNP_GUEST_REQUEST section for the structure */
-enum msg_type {
-	SNP_MSG_TYPE_INVALID = 0,
-	SNP_MSG_CPUID_REQ,
-	SNP_MSG_CPUID_RSP,
-	SNP_MSG_KEY_REQ,
-	SNP_MSG_KEY_RSP,
-	SNP_MSG_REPORT_REQ,
-	SNP_MSG_REPORT_RSP,
-	SNP_MSG_EXPORT_REQ,
-	SNP_MSG_EXPORT_RSP,
-	SNP_MSG_IMPORT_REQ,
-	SNP_MSG_IMPORT_RSP,
-	SNP_MSG_ABSORB_REQ,
-	SNP_MSG_ABSORB_RSP,
-	SNP_MSG_VMRK_REQ,
-	SNP_MSG_VMRK_RSP,
-
-	SNP_MSG_TYPE_MAX
-};
-
-enum aead_algo {
-	SNP_AEAD_INVALID,
-	SNP_AEAD_AES_256_GCM,
-};
-
-struct snp_guest_msg_hdr {
-	u8 authtag[MAX_AUTHTAG_LEN];
-	u64 msg_seqno;
-	u8 rsvd1[8];
-	u8 algo;
-	u8 hdr_version;
-	u16 hdr_sz;
-	u8 msg_type;
-	u8 msg_version;
-	u16 msg_sz;
-	u32 rsvd2;
-	u8 msg_vmpck;
-	u8 rsvd3[35];
-} __packed;
-
-struct snp_guest_msg {
-	struct snp_guest_msg_hdr hdr;
-	u8 payload[4000];
-} __packed;
-
-/*
- * The secrets page contains 96-bytes of reserved field that can be used by
- * the guest OS. The guest OS uses the area to save the message sequence
- * number for each VMPCK.
- *
- * See the GHCB spec section Secret page layout for the format for this area.
- */
-struct secrets_os_area {
-	u32 msg_seqno_0;
-	u32 msg_seqno_1;
-	u32 msg_seqno_2;
-	u32 msg_seqno_3;
-	u64 ap_jump_table_pa;
-	u8 rsvd[40];
-	u8 guest_usage[32];
-} __packed;
-
-#define VMPCK_KEY_LEN		32
-
-/* See the SNP spec version 0.9 for secrets page format */
-struct snp_secrets_page_layout {
-	u32 version;
-	u32 imien	: 1,
-	    rsvd1	: 31;
-	u32 fms;
-	u32 rsvd2;
-	u8 gosvw[16];
-	u8 vmpck0[VMPCK_KEY_LEN];
-	u8 vmpck1[VMPCK_KEY_LEN];
-	u8 vmpck2[VMPCK_KEY_LEN];
-	u8 vmpck3[VMPCK_KEY_LEN];
-	struct secrets_os_area os_area;
-	u8 rsvd3[3840];
-} __packed;
-
-#endif /* __VIRT_SEVGUEST_H__ */
