Return-Path: <linux-tip-commits+bounces-6818-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5330CBDFC83
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 18:55:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EB663E6D72
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 16:52:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E500B33A02B;
	Wed, 15 Oct 2025 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ErP3k0bc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R04JXbaL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B6633CE83;
	Wed, 15 Oct 2025 16:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547143; cv=none; b=jzTKHIOifumbpn4CYzFu8JkUNLwNQnDxebnPUSpFu03QLXh1IH/kD02ATvsOT+S/bHrRhf/BR5k2hGhZZvISn4Ts3I7d+ikqA90r+6ktI7h9AyiOvbOKbwH/H0529HE6As4Pb0gdEDKCqtOLRBYEad+7N8911GhXQ1p8/TDZBUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547143; c=relaxed/simple;
	bh=ZalEByCNIG1ykdmj8OjXuNo6hPtrxIZf7H84xMaJQsM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lwBKJYfIbm6kpJdxQLAfhVO1s9ppylHNNgl4zwGKxcjtqLG+ITT4JzWfljo07V3F3IsvwzSwqfp1YqNz1KTwqPLDnDaHsOQ397xQNHLpH6tDL4pC/JY94cth/wciAkEIq5V9wINItudTsFgv0vSvh5tSUVsCkvfLLoMjNTcUaxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ErP3k0bc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R04JXbaL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 16:52:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760547140;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7Lo8Gxv9CRsh3GFmczSSd/UU6e+CK+jpiOnnrMkUs8=;
	b=ErP3k0bcXc/jB1Bmrs2bdO9lRlUXnKjVwB8L0Vj2skJKeUPgW7CKDU0UdWUrCr8/crgdh+
	g1zpEKGvaPYkD3ADC7rIbYDJLnzfDsBKZeWjz9mGhj+rC6FjV5v+rVs8yl69R7xZuFQ9gI
	qcIKTgKLy+85q+N2/FxaI8XbEosTW86sFBfqc4/oel/2ckp/gno32gIVbFWgdAPqyzBHNy
	+JY0Nyx5ORAc9jwuQGjum6AuNqVbdqIDFlA02HfWvg/kMSR8VEUFDvpm/9LSSs3rnuZ6e7
	IAVH1FMQrNu6aBo9m4wjOi5FvkKPxNce8h1inI0zzU+dLC4fVkeq8eMEBQhFyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760547140;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p7Lo8Gxv9CRsh3GFmczSSd/UU6e+CK+jpiOnnrMkUs8=;
	b=R04JXbaLuLyC/ylS8Xce1VUadf6uqDlOEXlo4mfSNxOX3AgRCzTTa39ljo/oxtgiAWfbLD
	/LM4gM+inRNMp3Dg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Implement staging handler
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Anselm Busse <abusse@amazon.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250921224841.3545-6-chang.seok.bae@intel.com>
References: <20250921224841.3545-6-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176054713887.709179.9141072642252072061.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     afc3b5095461de8ca463a18f29a4ef6bdb92c2be
Gitweb:        https://git.kernel.org/tip/afc3b5095461de8ca463a18f29a4ef6bdb9=
2c2be
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Sun, 21 Sep 2025 15:48:39 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Oct 2025 16:47:37 +02:00

x86/microcode/intel: Implement staging handler

Previously, per-package staging invocations and their associated state
data were established. The next step is to implement the actual staging
handler according to the specified protocol. Below are key aspects to
note:

  (a)  Each staging process must begin by resetting the staging hardware.

  (b)  The staging hardware processes up to a page-sized chunk of the
       microcode image per iteration, requiring software to submit data
       incrementally.

  (c)  Once a data chunk is processed, the hardware responds with an
       offset in the image for the next chunk.

  (d)  The offset may indicate completion or request retransmission of an
       already transferred chunk. As long as the total transferred data
       remains within the predefined limit (twice the image size),
       retransmissions should be acceptable.

Incorporate them in the handler, while data transmission and mailbox
format handling are implemented separately.

  [ bp: Sort the headers in a reversed name-length order. ]

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Link: https://lore.kernel.org/20250320234104.8288-1-chang.seok.bae@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 123 ++++++++++++++++++++++++-
 1 file changed, 120 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index d49a4e6..5207c5a 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -16,9 +16,11 @@
 #include <linux/uaccess.h>
 #include <linux/initrd.h>
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/uio.h>
+#include <linux/io.h>
 #include <linux/mm.h>
=20
 #include <asm/cpu_device_id.h>
@@ -33,6 +35,15 @@ static const char ucode_path[] =3D "kernel/x86/microcode/G=
enuineIntel.bin";
=20
 #define UCODE_BSP_LOADED	((struct microcode_intel *)0x1UL)
=20
+/* Defines for the microcode staging mailbox interface */
+#define MBOX_REG_NUM		4
+#define MBOX_REG_SIZE		sizeof(u32)
+
+#define MBOX_CONTROL_OFFSET	0x0
+#define MBOX_STATUS_OFFSET	0x4
+
+#define MASK_MBOX_CTRL_ABORT	BIT(0)
+
 /* Current microcode patch used in early patching on the APs. */
 static struct microcode_intel *ucode_patch_va __read_mostly;
 static struct microcode_intel *ucode_patch_late __read_mostly;
@@ -317,13 +328,119 @@ static __init struct microcode_intel *scan_microcode(v=
oid *data, size_t size,
 }
=20
 /*
- * Handle the staging process using the mailbox MMIO interface.
+ * Prepare for a new microcode transfer: reset hardware and record the
+ * image size.
+ */
+static void init_stage(struct staging_state *ss)
+{
+	ss->ucode_len =3D get_totalsize(&ucode_patch_late->hdr);
+
+	/*
+	 * Abort any ongoing process, effectively resetting the device.
+	 * Unlike regular mailbox data processing requests, this
+	 * operation does not require a status check.
+	 */
+	writel(MASK_MBOX_CTRL_ABORT, ss->mmio_base + MBOX_CONTROL_OFFSET);
+}
+
+/*
+ * Update the chunk size and decide whether another chunk can be sent.
+ * This accounts for remaining data and retry limits.
+ */
+static bool can_send_next_chunk(struct staging_state *ss, int *err)
+{
+	/* A page size or remaining bytes if this is the final chunk */
+	ss->chunk_size =3D min(PAGE_SIZE, ss->ucode_len - ss->offset);
+
+	/*
+	 * Each microcode image is divided into chunks, each at most
+	 * one page size. A 10-chunk image would typically require 10
+	 * transactions.
+	 *
+	 * However, the hardware managing the mailbox has limited
+	 * resources and may not cache the entire image, potentially
+	 * requesting the same chunk multiple times.
+	 *
+	 * To tolerate this behavior, allow up to twice the expected
+	 * number of transactions (i.e., a 10-chunk image can take up to
+	 * 20 attempts).
+	 *
+	 * If the number of attempts exceeds this limit, treat it as
+	 * exceeding the maximum allowed transfer size.
+	 */
+	if (ss->bytes_sent + ss->chunk_size > ss->ucode_len * 2) {
+		*err =3D -EMSGSIZE;
+		return false;
+	}
+
+	*err =3D 0;
+	return true;
+}
+
+/*
+ * Determine whether staging is complete: either the hardware signaled
+ * the end offset, or no more transactions are permitted (retry limit
+ * reached).
+ */
+static inline bool staging_is_complete(struct staging_state *ss, int *err)
+{
+	return (ss->offset =3D=3D UINT_MAX) || !can_send_next_chunk(ss, err);
+}
+
+/*
+ * Transmit a chunk of the microcode image to the hardware.
+ * Return 0 on success, or an error code on failure.
+ */
+static int send_data_chunk(struct staging_state *ss, void *ucode_ptr __maybe=
_unused)
+{
+	pr_debug_once("Staging mailbox loading code needs to be implemented.\n");
+	return -EPROTONOSUPPORT;
+}
+
+/*
+ * Retrieve the next offset from the hardware response.
+ * Return 0 on success, or an error code on failure.
+ */
+static int fetch_next_offset(struct staging_state *ss)
+{
+	pr_debug_once("Staging mailbox response handling code needs to be implement=
ed.\n");
+	return -EPROTONOSUPPORT;
+}
+
+/*
+ * Handle the staging process using the mailbox MMIO interface. The
+ * microcode image is transferred in chunks until completion.
  * Return 0 on success or an error code on failure.
  */
 static int do_stage(u64 mmio_pa)
 {
-	pr_debug_once("Staging implementation is pending.\n");
-	return -EPROTONOSUPPORT;
+	struct staging_state ss =3D {};
+	int err;
+
+	ss.mmio_base =3D ioremap(mmio_pa, MBOX_REG_NUM * MBOX_REG_SIZE);
+	if (WARN_ON_ONCE(!ss.mmio_base))
+		return -EADDRNOTAVAIL;
+
+	init_stage(&ss);
+
+	/* Perform the staging process while within the retry limit */
+	while (!staging_is_complete(&ss, &err)) {
+		/* Send a chunk of microcode each time: */
+		err =3D send_data_chunk(&ss, ucode_patch_late);
+		if (err)
+			break;
+		/*
+		 * Then, ask the hardware which piece of the image it
+		 * needs next. The same piece may be sent more than once.
+		 */
+		err =3D fetch_next_offset(&ss);
+		if (err)
+			break;
+	}
+
+	iounmap(ss.mmio_base);
+
+	return err;
 }
=20
 static void stage_microcode(void)

