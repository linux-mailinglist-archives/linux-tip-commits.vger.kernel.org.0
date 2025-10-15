Return-Path: <linux-tip-commits+bounces-6817-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53454BDFC80
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 18:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 485AB4072C9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 16:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD2733CE96;
	Wed, 15 Oct 2025 16:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3WJx6ByD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fBba+Tr2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9054F1D5178;
	Wed, 15 Oct 2025 16:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547142; cv=none; b=id5cLUnsC0EDvcB3MKOAfcNAvn++whlU6OKYfrl+PIzYJB9UhkK3bLL5rzR8jxVOVzNaf3YhB/YcAaHov1OPcit5PE5o99SRswOm1sEQQGZdIcVgs6xqEGb4nQ1S1T3TkhvPnTQp1XWTLsAm4x5Voarygg97aCo+o2riiJNMRIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547142; c=relaxed/simple;
	bh=evq0ME0D6Vngo0Zhttt485wdMB+IXPR3Kw33eN0Gxjg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fGVgX3Yv6j4jIPSU3opHcit3e0Q2lScREzPZk+fASKpDQMhSO4HeNRByYgUSzGcNFdds235ds46tqfxSAhYUfJP/dWGh+N+eSNE7xmBdXIG913KEf5RzzxAOhtxegG6ztrMKRKiVYi87UI6aiWFKMFPeKMdG1vK/D8SnGCxZboo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3WJx6ByD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fBba+Tr2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 16:52:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760547138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GNT52JjbEtKhv8GUqWq2OOw/lpiKkZ6L1ElOIUS0d0=;
	b=3WJx6ByDnJaeaV86wKXdmuX16x7ZzNOBu2079Gm2stzPV2dDx2hGGRFuJPl/A+pcNAhL8e
	B1FjFLfSaSK3ufifl32ofNn10eKX7AYOOPYBgNQLmKs4psHdElgg3CFkZBA9vfO1W8B0BJ
	JJHFszrOI7W047B91bm1I2Cq7fx1fGZit4D9jKSZXgUfoCuA9pUcrJJ48EPyspTlWDlTqW
	49b/i92Q6LH2ez5+yeUBpLw/zIjwuEizVgIaavSccyK7Zihoaw9q6U73IAjqG7j8gZu4t/
	nTptMcsAt4Trv/1d70eFclnupkQbg/ylVnMy7hmk0PEV7v47Sin3XxMfJYDmLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760547138;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1GNT52JjbEtKhv8GUqWq2OOw/lpiKkZ6L1ElOIUS0d0=;
	b=fBba+Tr2yT/cOwieJcgbgGCuke45wavMytNwG7OLgegaD7JYkwAkVVpHBD9/prG+3zvhru
	Ji7Pne+UqcLUc/Dg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Support mailbox transfer
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Anselm Busse <abusse@amazon.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250921224841.3545-7-chang.seok.bae@intel.com>
References: <20250921224841.3545-7-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176054713754.709179.7051064090555339438.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     4ab410287bfd33e64073d8003b439da10356769d
Gitweb:        https://git.kernel.org/tip/4ab410287bfd33e64073d8003b439da1035=
6769d
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Sun, 21 Sep 2025 15:48:40 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Oct 2025 16:47:43 +02:00

x86/microcode/intel: Support mailbox transfer

The functions for sending microcode data and retrieving the next offset
were previously placeholders, as they need to handle a specific mailbox
format.

While the kernel supports similar mailboxes, none of them are compatible
with this one. Attempts to share code led to unnecessary complexity, so
add a dedicated implementation instead.

  [ bp: Sort the include properly. ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Link: https://lore.kernel.org/20250320234104.8288-1-chang.seok.bae@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 172 ++++++++++++++++++++++++-
 1 file changed, 166 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index 5207c5a..a42c5ef 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -13,6 +13,7 @@
 #define pr_fmt(fmt) "microcode: " fmt
 #include <linux/earlycpio.h>
 #include <linux/firmware.h>
+#include <linux/pci_ids.h>
 #include <linux/uaccess.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
@@ -41,8 +42,31 @@ static const char ucode_path[] =3D "kernel/x86/microcode/G=
enuineIntel.bin";
=20
 #define MBOX_CONTROL_OFFSET	0x0
 #define MBOX_STATUS_OFFSET	0x4
+#define MBOX_WRDATA_OFFSET	0x8
+#define MBOX_RDDATA_OFFSET	0xc
=20
 #define MASK_MBOX_CTRL_ABORT	BIT(0)
+#define MASK_MBOX_CTRL_GO	BIT(31)
+
+#define MASK_MBOX_STATUS_ERROR	BIT(2)
+#define MASK_MBOX_STATUS_READY	BIT(31)
+
+#define MASK_MBOX_RESP_SUCCESS	BIT(0)
+#define MASK_MBOX_RESP_PROGRESS	BIT(1)
+#define MASK_MBOX_RESP_ERROR	BIT(2)
+
+#define MBOX_CMD_LOAD		0x3
+#define MBOX_OBJ_STAGING	0xb
+#define MBOX_HEADER(size)	((PCI_VENDOR_ID_INTEL)    | \
+				 (MBOX_OBJ_STAGING << 16) | \
+				 ((u64)((size) / sizeof(u32)) << 32))
+
+/* The size of each mailbox header */
+#define MBOX_HEADER_SIZE	sizeof(u64)
+/* The size of staging hardware response */
+#define MBOX_RESPONSE_SIZE	sizeof(u64)
+
+#define MBOX_XACTION_TIMEOUT_MS	(10 * MSEC_PER_SEC)
=20
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
@@ -327,6 +351,49 @@ static __init struct microcode_intel *scan_microcode(voi=
d *data, size_t size,
 	return size ? NULL : patch;
 }
=20
+static inline u32 read_mbox_dword(void __iomem *mmio_base)
+{
+	u32 dword =3D readl(mmio_base + MBOX_RDDATA_OFFSET);
+
+	/* Acknowledge read completion to the staging hardware */
+	writel(0, mmio_base + MBOX_RDDATA_OFFSET);
+	return dword;
+}
+
+static inline void write_mbox_dword(void __iomem *mmio_base, u32 dword)
+{
+	writel(dword, mmio_base + MBOX_WRDATA_OFFSET);
+}
+
+static inline u64 read_mbox_header(void __iomem *mmio_base)
+{
+	u32 high, low;
+
+	low  =3D read_mbox_dword(mmio_base);
+	high =3D read_mbox_dword(mmio_base);
+
+	return ((u64)high << 32) | low;
+}
+
+static inline void write_mbox_header(void __iomem *mmio_base, u64 value)
+{
+	write_mbox_dword(mmio_base, value);
+	write_mbox_dword(mmio_base, value >> 32);
+}
+
+static void write_mbox_data(void __iomem *mmio_base, u32 *chunk, unsigned in=
t chunk_bytes)
+{
+	int i;
+
+	/*
+	 * The MMIO space is mapped as Uncached (UC). Each write arrives
+	 * at the device as an individual transaction in program order.
+	 * The device can then reassemble the sequence accordingly.
+	 */
+	for (i =3D 0; i < chunk_bytes / sizeof(u32); i++)
+		write_mbox_dword(mmio_base, chunk[i]);
+}
+
 /*
  * Prepare for a new microcode transfer: reset hardware and record the
  * image size.
@@ -378,23 +445,82 @@ static bool can_send_next_chunk(struct staging_state *s=
s, int *err)
 }
=20
 /*
+ * The hardware indicates completion by returning a sentinel end offset.
+ */
+static inline bool is_end_offset(u32 offset)
+{
+	return offset =3D=3D UINT_MAX;
+}
+
+/*
  * Determine whether staging is complete: either the hardware signaled
  * the end offset, or no more transactions are permitted (retry limit
  * reached).
  */
 static inline bool staging_is_complete(struct staging_state *ss, int *err)
 {
-	return (ss->offset =3D=3D UINT_MAX) || !can_send_next_chunk(ss, err);
+	return is_end_offset(ss->offset) || !can_send_next_chunk(ss, err);
+}
+
+/*
+ * Wait for the hardware to complete a transaction.
+ * Return 0 on success, or an error code on failure.
+ */
+static int wait_for_transaction(struct staging_state *ss)
+{
+	u32 timeout, status;
+
+	/* Allow time for hardware to complete the operation: */
+	for (timeout =3D 0; timeout < MBOX_XACTION_TIMEOUT_MS; timeout++) {
+		msleep(1);
+
+		status =3D readl(ss->mmio_base + MBOX_STATUS_OFFSET);
+		/* Break out early if the hardware is ready: */
+		if (status & MASK_MBOX_STATUS_READY)
+			break;
+	}
+
+	/* Check for explicit error response */
+	if (status & MASK_MBOX_STATUS_ERROR)
+		return -EIO;
+
+	/*
+	 * Hardware has neither responded to the action nor signaled any
+	 * error. Treat this as a timeout.
+	 */
+	if (!(status & MASK_MBOX_STATUS_READY))
+		return -ETIMEDOUT;
+
+	return 0;
 }
=20
 /*
  * Transmit a chunk of the microcode image to the hardware.
  * Return 0 on success, or an error code on failure.
  */
-static int send_data_chunk(struct staging_state *ss, void *ucode_ptr __maybe=
_unused)
+static int send_data_chunk(struct staging_state *ss, void *ucode_ptr)
 {
-	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
-	return -EPROTONOSUPPORT;
+	u32 *src_chunk =3D ucode_ptr + ss->offset;
+	u16 mbox_size;
+
+	/*
+	 * Write a 'request' mailbox object in this order:
+	 *  1. Mailbox header includes total size
+	 *  2. Command header specifies the load operation
+	 *  3. Data section contains a microcode chunk
+	 *
+	 * Thus, the mailbox size is two headers plus the chunk size.
+	 */
+	mbox_size =3D MBOX_HEADER_SIZE * 2 + ss->chunk_size;
+	write_mbox_header(ss->mmio_base, MBOX_HEADER(mbox_size));
+	write_mbox_header(ss->mmio_base, MBOX_CMD_LOAD);
+	write_mbox_data(ss->mmio_base, src_chunk, ss->chunk_size);
+	ss->bytes_sent +=3D ss->chunk_size;
+
+	/* Notify the hardware that the mailbox is ready for processing. */
+	writel(MASK_MBOX_CTRL_GO, ss->mmio_base + MBOX_CONTROL_OFFSET);
+
+	return wait_for_transaction(ss);
 }
=20
 /*
@@ -403,8 +529,42 @@ static int send_data_chunk(struct staging_state *ss, voi=
d *ucode_ptr __maybe_unu
  */
 static int fetch_next_offset(struct staging_state *ss)
 {
-	pr_debug_once("Staging mailbox response handling code needs to be implement=
ed.\n");
-	return -EPROTONOSUPPORT;
+	const u64 expected_header =3D MBOX_HEADER(MBOX_HEADER_SIZE + MBOX_RESPONSE_=
SIZE);
+	u32 offset, status;
+	u64 header;
+
+	/*
+	 * The 'response' mailbox returns three fields, in order:
+	 *  1. Header
+	 *  2. Next offset in the microcode image
+	 *  3. Status flags
+	 */
+	header =3D read_mbox_header(ss->mmio_base);
+	offset =3D read_mbox_dword(ss->mmio_base);
+	status =3D read_mbox_dword(ss->mmio_base);
+
+	/* All valid responses must start with the expected header. */
+	if (header !=3D expected_header) {
+		pr_err_once("staging: invalid response header (0x%llx)\n", header);
+		return -EBADR;
+	}
+
+	/*
+	 * Verify the offset: If not at the end marker, it must not
+	 * exceed the microcode image length.
+	 */
+	if (!is_end_offset(offset) && offset > ss->ucode_len) {
+		pr_err_once("staging: invalid offset (%u) past the image end (%u)\n",
+			    offset, ss->ucode_len);
+		return -EINVAL;
+	}
+
+	/* Hardware may report errors explicitly in the status field */
+	if (status & MASK_MBOX_RESP_ERROR)
+		return -EPROTO;
+
+	ss->offset =3D offset;
+	return 0;
 }
=20
 /*

