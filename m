Return-Path: <linux-tip-commits+bounces-6678-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E38B84953
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 14:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B67E1620632
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Sep 2025 12:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DE52FDC58;
	Thu, 18 Sep 2025 12:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RnECXbJ5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4YrVSQHh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305CF2FC027;
	Thu, 18 Sep 2025 12:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758198596; cv=none; b=YbskV2AfoMBFi6M+uCfU2DdlFJhjgcrgIPkUS4lgWyX1G09Q1n4XiZqlAUrfmqPDhhYU89Ryy/6TEwnmjxrFaimx4NG1c005L2psIj4H8GqjtBUbMH5vTHMHWNHRfNxD2t+rNXmmbXU8do2fV/9AuZ3PfPAw/Rr2viODb0KJH3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758198596; c=relaxed/simple;
	bh=UsSSbwOTSwXTnVv/MAlv2qNzgm1SZNKNhyptPFFtuic=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NcZbwRaK6amioAN+E4M0BNBKOIi7tfWx79R7WkatqVIbmkK3HeTWWtGJIq5uVknZNrJYYgZei2d4C2GgTUH/OVR+oguoxY2P/2s9FvqA3Zr5hSNbxVEWZDiYo0MwdXFSzsAfnCWUzh2V9wxToG4Z137iNG5yP+LxiLwQAG7ICls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RnECXbJ5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4YrVSQHh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Sep 2025 12:29:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758198591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvZNf0ZicYWR5a1bjD2eAb47T/gVawfebiG0SjTKQ9s=;
	b=RnECXbJ5HbQNMW7YMP2oX/F7VQbpssze2hwY65pFD8jFyS7vx1GR9eNKNtNstGyhhDdIN2
	6oo7otGb6eEAdmiOxrjExIMoH7ZyMluMyCDOV+I8KNG61zsOLpKx3rbXme+DKV53AuBLZN
	ebWM+6nqKgH7xLKqqhpAXtJ0Px8Ov7Ih8z0I7mkiwCbZ6v+7/a0lFZB6KEqL0FkdKWNb6A
	9H+LOMnf017huv9x6OSkj7Ai4jLzwbPO4sBzbw+28+PCj9NF5soSQTpi5g/UQLHg8MwBXO
	PJaS2hhwwXWle31MRilxSb2aPTAv5FG0rBSvwd2MtsjLYWUdV5AgdnAisL9N6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758198591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KvZNf0ZicYWR5a1bjD2eAb47T/gVawfebiG0SjTKQ9s=;
	b=4YrVSQHhDK/q5urAmmRNxOdqO2081mhRlNx25EzrREv/GTXB0AtN1i/ux/4G2WrM+45phy
	k5gYtgj4akzBMLDw==
From: "tip-bot2 for Ashish Kalra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] crypto: ccp - Add AMD Seamless Firmware Servicing
 (SFS) driver
Cc: Ashish Kalra <ashish.kalra@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc07e43d87fc312b7694aeadfa357033400954a1f=2E1758057?=
 =?utf-8?q?691=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cc07e43d87fc312b7694aeadfa357033400954a1f=2E17580576?=
 =?utf-8?q?91=2Egit=2Eashish=2Ekalra=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175819858960.709179.7091263384262345955.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     648dbccc03a000cd64c2a9d86012d98053545e64
Gitweb:        https://git.kernel.org/tip/648dbccc03a000cd64c2a9d86012d980535=
45e64
Author:        Ashish Kalra <ashish.kalra@amd.com>
AuthorDate:    Tue, 16 Sep 2025 21:29:49=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 17 Sep 2025 12:17:05 +02:00

crypto: ccp - Add AMD Seamless Firmware Servicing (SFS) driver

AMD Seamless Firmware Servicing (SFS) is a secure method to allow
non-persistent updates to running firmware and settings without
requiring BIOS reflash and/or system reset.

SFS does not address anything that runs on the x86 processors and
it can be used to update ASP firmware, modules, register settings
and update firmware for other microprocessors like TMPM, etc.

SFS driver support adds ioctl support to communicate the SFS
commands to the ASP/PSP by using the TEE mailbox interface.

The Seamless Firmware Servicing (SFS) driver is added as a
PSP sub-device.

For detailed information, please look at the SFS specifications:
https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specific=
ations/58604.pdf

Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
Link: https://lore.kernel.org/cover.1758057691.git.ashish.kalra@amd.com
---
 drivers/crypto/ccp/Makefile         |   3 +-
 drivers/crypto/ccp/psp-dev.c        |  20 ++-
 drivers/crypto/ccp/psp-dev.h        |   8 +-
 drivers/crypto/ccp/sfs.c            | 311 +++++++++++++++++++++++++++-
 drivers/crypto/ccp/sfs.h            |  47 ++++-
 include/linux/psp-platform-access.h |   2 +-
 include/uapi/linux/psp-sfs.h        |  87 ++++++++-
 7 files changed, 476 insertions(+), 2 deletions(-)
 create mode 100644 drivers/crypto/ccp/sfs.c
 create mode 100644 drivers/crypto/ccp/sfs.h
 create mode 100644 include/uapi/linux/psp-sfs.h

diff --git a/drivers/crypto/ccp/Makefile b/drivers/crypto/ccp/Makefile
index 3944849..a9626b3 100644
--- a/drivers/crypto/ccp/Makefile
+++ b/drivers/crypto/ccp/Makefile
@@ -13,7 +13,8 @@ ccp-$(CONFIG_CRYPTO_DEV_SP_PSP) +=3D psp-dev.o \
                                    tee-dev.o \
                                    platform-access.o \
                                    dbc.o \
-                                   hsti.o
+                                   hsti.o \
+                                   sfs.o
=20
 obj-$(CONFIG_CRYPTO_DEV_CCP_CRYPTO) +=3D ccp-crypto.o
 ccp-crypto-objs :=3D ccp-crypto-main.o \
diff --git a/drivers/crypto/ccp/psp-dev.c b/drivers/crypto/ccp/psp-dev.c
index 1c5a718..9e21da0 100644
--- a/drivers/crypto/ccp/psp-dev.c
+++ b/drivers/crypto/ccp/psp-dev.c
@@ -17,6 +17,7 @@
 #include "psp-dev.h"
 #include "sev-dev.h"
 #include "tee-dev.h"
+#include "sfs.h"
 #include "platform-access.h"
 #include "dbc.h"
 #include "hsti.h"
@@ -182,6 +183,17 @@ static int psp_check_tee_support(struct psp_device *psp)
 	return 0;
 }
=20
+static int psp_check_sfs_support(struct psp_device *psp)
+{
+	/* Check if device supports SFS feature */
+	if (!psp->capability.sfs) {
+		dev_dbg(psp->dev, "psp does not support SFS\n");
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
 static int psp_init(struct psp_device *psp)
 {
 	int ret;
@@ -198,6 +210,12 @@ static int psp_init(struct psp_device *psp)
 			return ret;
 	}
=20
+	if (!psp_check_sfs_support(psp)) {
+		ret =3D sfs_dev_init(psp);
+		if (ret)
+			return ret;
+	}
+
 	if (psp->vdata->platform_access) {
 		ret =3D platform_access_dev_init(psp);
 		if (ret)
@@ -302,6 +320,8 @@ void psp_dev_destroy(struct sp_device *sp)
=20
 	tee_dev_destroy(psp);
=20
+	sfs_dev_destroy(psp);
+
 	dbc_dev_destroy(psp);
=20
 	platform_access_dev_destroy(psp);
diff --git a/drivers/crypto/ccp/psp-dev.h b/drivers/crypto/ccp/psp-dev.h
index e43ce87..268c83f 100644
--- a/drivers/crypto/ccp/psp-dev.h
+++ b/drivers/crypto/ccp/psp-dev.h
@@ -32,7 +32,8 @@ union psp_cap_register {
 		unsigned int sev			:1,
 			     tee			:1,
 			     dbc_thru_ext		:1,
-			     rsvd1			:4,
+			     sfs			:1,
+			     rsvd1			:3,
 			     security_reporting		:1,
 			     fused_part			:1,
 			     rsvd2			:1,
@@ -68,6 +69,7 @@ struct psp_device {
 	void *tee_data;
 	void *platform_access_data;
 	void *dbc_data;
+	void *sfs_data;
=20
 	union psp_cap_register capability;
 };
@@ -118,12 +120,16 @@ struct psp_ext_request {
  * @PSP_SUB_CMD_DBC_SET_UID:		Set UID for DBC
  * @PSP_SUB_CMD_DBC_GET_PARAMETER:	Get parameter from DBC
  * @PSP_SUB_CMD_DBC_SET_PARAMETER:	Set parameter for DBC
+ * @PSP_SUB_CMD_SFS_GET_FW_VERS:	Get firmware versions for ASP and other MP
+ * @PSP_SUB_CMD_SFS_UPDATE:		Command to load, verify and execute SFS package
  */
 enum psp_sub_cmd {
 	PSP_SUB_CMD_DBC_GET_NONCE	=3D PSP_DYNAMIC_BOOST_GET_NONCE,
 	PSP_SUB_CMD_DBC_SET_UID		=3D PSP_DYNAMIC_BOOST_SET_UID,
 	PSP_SUB_CMD_DBC_GET_PARAMETER	=3D PSP_DYNAMIC_BOOST_GET_PARAMETER,
 	PSP_SUB_CMD_DBC_SET_PARAMETER	=3D PSP_DYNAMIC_BOOST_SET_PARAMETER,
+	PSP_SUB_CMD_SFS_GET_FW_VERS	=3D PSP_SFS_GET_FW_VERSIONS,
+	PSP_SUB_CMD_SFS_UPDATE		=3D PSP_SFS_UPDATE,
 };
=20
 int psp_extended_mailbox_cmd(struct psp_device *psp, unsigned int timeout_ms=
ecs,
diff --git a/drivers/crypto/ccp/sfs.c b/drivers/crypto/ccp/sfs.c
new file mode 100644
index 0000000..2f4beaa
--- /dev/null
+++ b/drivers/crypto/ccp/sfs.c
@@ -0,0 +1,311 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Secure Processor Seamless Firmware Servicing support.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ *
+ * Author: Ashish Kalra <ashish.kalra@amd.com>
+ */
+
+#include <linux/firmware.h>
+
+#include "sfs.h"
+#include "sev-dev.h"
+
+#define SFS_DEFAULT_TIMEOUT		(10 * MSEC_PER_SEC)
+#define SFS_MAX_PAYLOAD_SIZE		(2 * 1024 * 1024)
+#define SFS_NUM_2MB_PAGES_CMDBUF	(SFS_MAX_PAYLOAD_SIZE / PMD_SIZE)
+#define SFS_NUM_PAGES_CMDBUF		(SFS_MAX_PAYLOAD_SIZE / PAGE_SIZE)
+
+static DEFINE_MUTEX(sfs_ioctl_mutex);
+
+static struct sfs_misc_dev *misc_dev;
+
+static int send_sfs_cmd(struct sfs_device *sfs_dev, int msg)
+{
+	int ret;
+
+	sfs_dev->command_buf->hdr.status =3D 0;
+	sfs_dev->command_buf->hdr.sub_cmd_id =3D msg;
+
+	ret =3D psp_extended_mailbox_cmd(sfs_dev->psp,
+				       SFS_DEFAULT_TIMEOUT,
+				       (struct psp_ext_request *)sfs_dev->command_buf);
+	if (ret =3D=3D -EIO) {
+		dev_dbg(sfs_dev->dev,
+			 "msg 0x%x failed with PSP error: 0x%x, extended status: 0x%x\n",
+			 msg, sfs_dev->command_buf->hdr.status,
+			 *(u32 *)sfs_dev->command_buf->buf);
+	}
+
+	return ret;
+}
+
+static int send_sfs_get_fw_versions(struct sfs_device *sfs_dev)
+{
+	/*
+	 * SFS_GET_FW_VERSIONS command needs the output buffer to be
+	 * initialized to 0xC7 in every byte.
+	 */
+	memset(sfs_dev->command_buf->sfs_buffer, 0xc7, PAGE_SIZE);
+	sfs_dev->command_buf->hdr.payload_size =3D 2 * PAGE_SIZE;
+
+	return send_sfs_cmd(sfs_dev, PSP_SFS_GET_FW_VERSIONS);
+}
+
+static int send_sfs_update_package(struct sfs_device *sfs_dev, const char *p=
ayload_name)
+{
+	char payload_path[PAYLOAD_NAME_SIZE + sizeof("amd/")];
+	const struct firmware *firmware;
+	unsigned long package_size;
+	int ret;
+
+	/* Sanitize userspace provided payload name */
+	if (!strnchr(payload_name, PAYLOAD_NAME_SIZE, '\0'))
+		return -EINVAL;
+
+	snprintf(payload_path, sizeof(payload_path), "amd/%s", payload_name);
+
+	ret =3D firmware_request_nowarn(&firmware, payload_path, sfs_dev->dev);
+	if (ret < 0) {
+		dev_warn_ratelimited(sfs_dev->dev, "firmware request failed for %s (%d)\n",
+				     payload_path, ret);
+		return -ENOENT;
+	}
+
+	/*
+	 * SFS Update Package command's input buffer contains TEE_EXT_CMD_BUFFER
+	 * followed by the Update Package and it should be 64KB aligned.
+	 */
+	package_size =3D ALIGN(firmware->size + PAGE_SIZE, 0x10000U);
+
+	/*
+	 * SFS command buffer is a pre-allocated 2MB buffer, fail update package
+	 * if SFS payload is larger than the pre-allocated command buffer.
+	 */
+	if (package_size > SFS_MAX_PAYLOAD_SIZE) {
+		dev_warn_ratelimited(sfs_dev->dev,
+			 "SFS payload size %ld larger than maximum supported payload size of %u\n=
",
+			 package_size, SFS_MAX_PAYLOAD_SIZE);
+		release_firmware(firmware);
+		return -E2BIG;
+	}
+
+	/*
+	 * Copy firmware data to a HV_Fixed memory region.
+	 */
+	memcpy(sfs_dev->command_buf->sfs_buffer, firmware->data, firmware->size);
+	sfs_dev->command_buf->hdr.payload_size =3D package_size;
+
+	release_firmware(firmware);
+
+	return send_sfs_cmd(sfs_dev, PSP_SFS_UPDATE);
+}
+
+static long sfs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
+{
+	struct sfs_user_get_fw_versions __user *sfs_get_fw_versions;
+	struct sfs_user_update_package __user *sfs_update_package;
+	struct psp_device *psp_master =3D psp_get_master_device();
+	char payload_name[PAYLOAD_NAME_SIZE];
+	struct sfs_device *sfs_dev;
+	int ret =3D 0;
+
+	if (!psp_master || !psp_master->sfs_data)
+		return -ENODEV;
+
+	sfs_dev =3D psp_master->sfs_data;
+
+	guard(mutex)(&sfs_ioctl_mutex);
+
+	switch (cmd) {
+	case SFSIOCFWVERS:
+		dev_dbg(sfs_dev->dev, "in SFSIOCFWVERS\n");
+
+		sfs_get_fw_versions =3D (struct sfs_user_get_fw_versions __user *)arg;
+
+		ret =3D send_sfs_get_fw_versions(sfs_dev);
+		if (ret && ret !=3D -EIO)
+			return ret;
+
+		/*
+		 * Return SFS status and extended status back to userspace
+		 * if PSP status indicated success or command error.
+		 */
+		if (copy_to_user(&sfs_get_fw_versions->blob, sfs_dev->command_buf->sfs_buf=
fer,
+				 PAGE_SIZE))
+			return -EFAULT;
+		if (copy_to_user(&sfs_get_fw_versions->sfs_status,
+				 &sfs_dev->command_buf->hdr.status,
+				 sizeof(sfs_get_fw_versions->sfs_status)))
+			return -EFAULT;
+		if (copy_to_user(&sfs_get_fw_versions->sfs_extended_status,
+				 &sfs_dev->command_buf->buf,
+				 sizeof(sfs_get_fw_versions->sfs_extended_status)))
+			return -EFAULT;
+		break;
+	case SFSIOCUPDATEPKG:
+		dev_dbg(sfs_dev->dev, "in SFSIOCUPDATEPKG\n");
+
+		sfs_update_package =3D (struct sfs_user_update_package __user *)arg;
+
+		if (copy_from_user(payload_name, sfs_update_package->payload_name,
+				   PAYLOAD_NAME_SIZE))
+			return -EFAULT;
+
+		ret =3D send_sfs_update_package(sfs_dev, payload_name);
+		if (ret && ret !=3D -EIO)
+			return ret;
+
+		/*
+		 * Return SFS status and extended status back to userspace
+		 * if PSP status indicated success or command error.
+		 */
+		if (copy_to_user(&sfs_update_package->sfs_status,
+				 &sfs_dev->command_buf->hdr.status,
+				 sizeof(sfs_update_package->sfs_status)))
+			return -EFAULT;
+		if (copy_to_user(&sfs_update_package->sfs_extended_status,
+				 &sfs_dev->command_buf->buf,
+				 sizeof(sfs_update_package->sfs_extended_status)))
+			return -EFAULT;
+		break;
+	default:
+		ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static const struct file_operations sfs_fops =3D {
+	.owner	=3D THIS_MODULE,
+	.unlocked_ioctl =3D sfs_ioctl,
+};
+
+static void sfs_exit(struct kref *ref)
+{
+	misc_deregister(&misc_dev->misc);
+	kfree(misc_dev);
+	misc_dev =3D NULL;
+}
+
+void sfs_dev_destroy(struct psp_device *psp)
+{
+	struct sfs_device *sfs_dev =3D psp->sfs_data;
+
+	if (!sfs_dev)
+		return;
+
+	/*
+	 * Change SFS command buffer back to the default "Write-Back" type.
+	 */
+	set_memory_wb((unsigned long)sfs_dev->command_buf, SFS_NUM_PAGES_CMDBUF);
+
+	snp_free_hv_fixed_pages(sfs_dev->page);
+
+	if (sfs_dev->misc)
+		kref_put(&misc_dev->refcount, sfs_exit);
+
+	psp->sfs_data =3D NULL;
+}
+
+/* Based on sev_misc_init() */
+static int sfs_misc_init(struct sfs_device *sfs)
+{
+	struct device *dev =3D sfs->dev;
+	int ret;
+
+	/*
+	 * SFS feature support can be detected on multiple devices but the SFS
+	 * FW commands must be issued on the master. During probe, we do not
+	 * know the master hence we create /dev/sfs on the first device probe.
+	 */
+	if (!misc_dev) {
+		struct miscdevice *misc;
+
+		misc_dev =3D kzalloc(sizeof(*misc_dev), GFP_KERNEL);
+		if (!misc_dev)
+			return -ENOMEM;
+
+		misc =3D &misc_dev->misc;
+		misc->minor =3D MISC_DYNAMIC_MINOR;
+		misc->name =3D "sfs";
+		misc->fops =3D &sfs_fops;
+		misc->mode =3D 0600;
+
+		ret =3D misc_register(misc);
+		if (ret)
+			return ret;
+
+		kref_init(&misc_dev->refcount);
+	} else {
+		kref_get(&misc_dev->refcount);
+	}
+
+	sfs->misc =3D misc_dev;
+	dev_dbg(dev, "registered SFS device\n");
+
+	return 0;
+}
+
+int sfs_dev_init(struct psp_device *psp)
+{
+	struct device *dev =3D psp->dev;
+	struct sfs_device *sfs_dev;
+	struct page *page;
+	int ret =3D -ENOMEM;
+
+	sfs_dev =3D devm_kzalloc(dev, sizeof(*sfs_dev), GFP_KERNEL);
+	if (!sfs_dev)
+		return -ENOMEM;
+
+	/*
+	 * Pre-allocate 2MB command buffer for all SFS commands using
+	 * SNP HV_Fixed page allocator which also transitions the
+	 * SFS command buffer to HV_Fixed page state if SNP is enabled.
+	 */
+	page =3D snp_alloc_hv_fixed_pages(SFS_NUM_2MB_PAGES_CMDBUF);
+	if (!page) {
+		dev_dbg(dev, "Command Buffer HV-Fixed page allocation failed\n");
+		goto cleanup_dev;
+	}
+	sfs_dev->page =3D page;
+	sfs_dev->command_buf =3D page_address(page);
+
+	dev_dbg(dev, "Command buffer 0x%px to be marked as HV_Fixed\n", sfs_dev->co=
mmand_buf);
+
+	/*
+	 * SFS command buffer must be mapped as non-cacheable.
+	 */
+	ret =3D set_memory_uc((unsigned long)sfs_dev->command_buf, SFS_NUM_PAGES_CM=
DBUF);
+	if (ret) {
+		dev_dbg(dev, "Set memory uc failed\n");
+		goto cleanup_cmd_buf;
+	}
+
+	dev_dbg(dev, "Command buffer 0x%px marked uncacheable\n", sfs_dev->command_=
buf);
+
+	psp->sfs_data =3D sfs_dev;
+	sfs_dev->dev =3D dev;
+	sfs_dev->psp =3D psp;
+
+	ret =3D sfs_misc_init(sfs_dev);
+	if (ret)
+		goto cleanup_mem_attr;
+
+	dev_notice(sfs_dev->dev, "SFS support is available\n");
+
+	return 0;
+
+cleanup_mem_attr:
+	set_memory_wb((unsigned long)sfs_dev->command_buf, SFS_NUM_PAGES_CMDBUF);
+
+cleanup_cmd_buf:
+	snp_free_hv_fixed_pages(page);
+
+cleanup_dev:
+	psp->sfs_data =3D NULL;
+	devm_kfree(dev, sfs_dev);
+
+	return ret;
+}
diff --git a/drivers/crypto/ccp/sfs.h b/drivers/crypto/ccp/sfs.h
new file mode 100644
index 0000000..97704c2
--- /dev/null
+++ b/drivers/crypto/ccp/sfs.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * AMD Platform Security Processor (PSP) Seamless Firmware (SFS) Support.
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ *
+ * Author: Ashish Kalra <ashish.kalra@amd.com>
+ */
+
+#ifndef __SFS_H__
+#define __SFS_H__
+
+#include <uapi/linux/psp-sfs.h>
+
+#include <linux/device.h>
+#include <linux/miscdevice.h>
+#include <linux/psp-sev.h>
+#include <linux/psp-platform-access.h>
+#include <linux/set_memory.h>
+
+#include "psp-dev.h"
+
+struct sfs_misc_dev {
+	struct kref refcount;
+	struct miscdevice misc;
+};
+
+struct sfs_command {
+	struct psp_ext_req_buffer_hdr hdr;
+	u8 buf[PAGE_SIZE - sizeof(struct psp_ext_req_buffer_hdr)];
+	u8 sfs_buffer[];
+} __packed;
+
+struct sfs_device {
+	struct device *dev;
+	struct psp_device *psp;
+
+	struct page *page;
+	struct sfs_command *command_buf;
+
+	struct sfs_misc_dev *misc;
+};
+
+void sfs_dev_destroy(struct psp_device *psp);
+int sfs_dev_init(struct psp_device *psp);
+
+#endif /* __SFS_H__ */
diff --git a/include/linux/psp-platform-access.h b/include/linux/psp-platform=
-access.h
index 1504fb0..540abf7 100644
--- a/include/linux/psp-platform-access.h
+++ b/include/linux/psp-platform-access.h
@@ -7,6 +7,8 @@
=20
 enum psp_platform_access_msg {
 	PSP_CMD_NONE			=3D 0x0,
+	PSP_SFS_GET_FW_VERSIONS,
+	PSP_SFS_UPDATE,
 	PSP_CMD_HSTI_QUERY		=3D 0x14,
 	PSP_I2C_REQ_BUS_CMD		=3D 0x64,
 	PSP_DYNAMIC_BOOST_GET_NONCE,
diff --git a/include/uapi/linux/psp-sfs.h b/include/uapi/linux/psp-sfs.h
new file mode 100644
index 0000000..94e5167
--- /dev/null
+++ b/include/uapi/linux/psp-sfs.h
@@ -0,0 +1,87 @@
+/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/*
+ * Userspace interface for AMD Seamless Firmware Servicing (SFS)
+ *
+ * Copyright (C) 2025 Advanced Micro Devices, Inc.
+ *
+ * Author: Ashish Kalra <ashish.kalra@amd.com>
+ */
+
+#ifndef __PSP_SFS_USER_H__
+#define __PSP_SFS_USER_H__
+
+#include <linux/types.h>
+
+/**
+ * SFS: AMD Seamless Firmware Support (SFS) interface
+ */
+
+#define PAYLOAD_NAME_SIZE	64
+#define TEE_EXT_CMD_BUFFER_SIZE	4096
+
+/**
+ * struct sfs_user_get_fw_versions - get current level of base firmware (out=
put).
+ * @blob:                  current level of base firmware for ASP and patch =
levels (input/output).
+ * @sfs_status:            32-bit SFS status value (output).
+ * @sfs_extended_status:   32-bit SFS extended status value (output).
+ */
+struct sfs_user_get_fw_versions {
+	__u8	blob[TEE_EXT_CMD_BUFFER_SIZE];
+	__u32	sfs_status;
+	__u32	sfs_extended_status;
+} __packed;
+
+/**
+ * struct sfs_user_update_package - update SFS package (input).
+ * @payload_name:          name of SFS package to load, verify and execute (=
input).
+ * @sfs_status:            32-bit SFS status value (output).
+ * @sfs_extended_status:   32-bit SFS extended status value (output).
+ */
+struct sfs_user_update_package {
+	char	payload_name[PAYLOAD_NAME_SIZE];
+	__u32	sfs_status;
+	__u32	sfs_extended_status;
+} __packed;
+
+/**
+ * Seamless Firmware Support (SFS) IOC
+ *
+ * possible return codes for all SFS IOCTLs:
+ *  0:          success
+ *  -EINVAL:    invalid input
+ *  -E2BIG:     excess data passed
+ *  -EFAULT:    failed to copy to/from userspace
+ *  -EBUSY:     mailbox in recovery or in use
+ *  -ENODEV:    driver not bound with PSP device
+ *  -EACCES:    request isn't authorized
+ *  -EINVAL:    invalid parameter
+ *  -ETIMEDOUT: request timed out
+ *  -EAGAIN:    invalid request for state machine
+ *  -ENOENT:    not implemented
+ *  -ENFILE:    overflow
+ *  -EPERM:     invalid signature
+ *  -EIO:       PSP I/O error
+ */
+#define SFS_IOC_TYPE	'S'
+
+/**
+ * SFSIOCFWVERS - returns blob containing FW versions
+ *                ASP provides the current level of Base Firmware for the ASP
+ *                and the other microprocessors as well as current patch
+ *                level(s).
+ */
+#define SFSIOCFWVERS	_IOWR(SFS_IOC_TYPE, 0x1, struct sfs_user_get_fw_version=
s)
+
+/**
+ * SFSIOCUPDATEPKG - updates package/payload
+ *                   ASP loads, verifies and executes the SFS package.
+ *                   By default, the SFS package/payload is loaded from
+ *                   /lib/firmware/amd, but alternative firmware loading
+ *                   path can be specified using kernel parameter
+ *                   firmware_class.path or the firmware loading path
+ *                   can be customized using sysfs file:
+ *                   /sys/module/firmware_class/parameters/path.
+ */
+#define SFSIOCUPDATEPKG	_IOWR(SFS_IOC_TYPE, 0x2, struct sfs_user_update_pack=
age)
+
+#endif /* __PSP_SFS_USER_H__ */

