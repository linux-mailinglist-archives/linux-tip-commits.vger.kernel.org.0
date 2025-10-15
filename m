Return-Path: <linux-tip-commits+bounces-6819-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FACFBDFC26
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 18:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC14819A8104
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Oct 2025 16:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D52533CEBB;
	Wed, 15 Oct 2025 16:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k61PgTvy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mqkyQ5oA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5662533CE9C;
	Wed, 15 Oct 2025 16:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760547145; cv=none; b=VLpGwPsncGunWqjGymItrLl3EzzbKtUW+FIQXrs56P4TJmyHtBiNVyvQ6fQDDtwLy5pMXeKdchFs+aLcco+04lkTylN9gymPn7c07aOwFiRHEulIs7gi0WTEKKAqRLuGol/9SHKuE23lGVq2hW+wWicnBeA0CDY9CwHB6zWWHK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760547145; c=relaxed/simple;
	bh=x0NaD+9sEf5EERwTNeg4gVJTyUgFYNsF+SWoVDLzvQo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TdMU7C01HSANGl0YstgxsaTnC/e74Qz0VNfRiUpdoBCXhmrp5SSggwzrk6hd9X0EAMpip5MPtt58XY58S+u7vgkJJVJonhn1gVL63rbQW0Z0QH25B1P5qLjSMa8Z9o5ShTkcP4ZUh4pNyBKo4WqnRisNQl5jO9cJMS2T4CtVcGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k61PgTvy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mqkyQ5oA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Oct 2025 16:52:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760547141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85eMQYAMb5WfjlFeqFYVMEPTIoasG/+xBcLPg4ye8U0=;
	b=k61PgTvyf5fs84dMFAgnochbnNUz4VqghrPT/o24gXCyN5EUtKjjMJkPAPuDThL5MExiKb
	NhWrAxKsXjKWF+dHdUORxaehVmj/AeCCxCPYc1oQqmMBvu2sMj7jDOhi6eIsIBU62Bbkev
	UXonNuTNmpjMrMnQz+Npi5MHez6ZXtfUpOzkciAuWVKmP30dPL5ZEp2SW01n9AO9qrkfos
	j1/I7LLrvby+R6paAwthhCgBV2f63Mtcb/BWTasOMUUNhFsC+MhWxj3Iyv9TXJc4f9u3mD
	fzNHb5WjvgZKZbAesqSV43aW4MJs6wpG+dpsP/p4IzvF/PVCPf8Fsppc0gy4xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760547141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=85eMQYAMb5WfjlFeqFYVMEPTIoasG/+xBcLPg4ye8U0=;
	b=mqkyQ5oAfVTYa07SycdxXEbQ0LAcfC1qAN2bfxDPMGeJiEAoKDul4l5K4U7v1q3KF2ICfv
	KUe/VLhX48Ej2rDg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Define staging state struct
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Tony Luck <tony.luck@intel.com>,
 Anselm Busse <abusse@amazon.de>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250921224841.3545-5-chang.seok.bae@intel.com>
References: <20250921224841.3545-5-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176054714030.709179.18274721781740431275.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     079b90d4ba8dfa9603ecf400556894224021452d
Gitweb:        https://git.kernel.org/tip/079b90d4ba8dfa9603ecf40055689422402=
1452d
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Sun, 21 Sep 2025 15:48:38 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 15 Oct 2025 16:47:31 +02:00

x86/microcode/intel: Define staging state struct

Define a staging_state struct to simplify function prototypes by consolidating
relevant data, instead of passing multiple local variables.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Anselm Busse <abusse@amazon.de>
Link: https://lore.kernel.org/20250320234104.8288-1-chang.seok.bae@intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/micr=
ocode/intel.c
index 216595a..d49a4e6 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -54,6 +54,23 @@ struct extended_sigtable {
 	struct extended_signature	sigs[];
 };
=20
+/**
+ * struct staging_state - Track the current staging process state
+ *
+ * @mmio_base:		MMIO base address for staging
+ * @ucode_len:		Total size of the microcode image
+ * @chunk_size:		Size of each data piece
+ * @bytes_sent:		Total bytes transmitted so far
+ * @offset:		Current offset in the microcode image
+ */
+struct staging_state {
+	void __iomem		*mmio_base;
+	unsigned int		ucode_len;
+	unsigned int		chunk_size;
+	unsigned int		bytes_sent;
+	unsigned int		offset;
+};
+
 #define DEFAULT_UCODE_TOTALSIZE (DEFAULT_UCODE_DATASIZE + MC_HEADER_SIZE)
 #define EXT_HEADER_SIZE		(sizeof(struct extended_sigtable))
 #define EXT_SIGNATURE_SIZE	(sizeof(struct extended_signature))

