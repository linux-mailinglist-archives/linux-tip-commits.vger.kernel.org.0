Return-Path: <linux-tip-commits+bounces-3884-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC48FA4D916
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5C071885967
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C9C1FC7F7;
	Tue,  4 Mar 2025 09:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dUE/+jbm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G80lCqoU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E6033998;
	Tue,  4 Mar 2025 09:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081657; cv=none; b=EVTVoCExub/ap9wGLB00RePBmKeLMzyXXaqBS5gZ5K/ATy0LNk6dEmDmc2U7RNcXmjToWmz7Fau5KMDot7fOrh0NUkSrcYRfvSK8RrIbhZ0cWymPxoG1122SHzLguC4X7FZSFPN3O7PEaWZ8sVAmClGi+QOfrPevUEh1rDfLHrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081657; c=relaxed/simple;
	bh=H3pVIaSA4COTz09Om8jCkdsmP7dRkEU7CJxSAn4SeKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A8vV/6XBrp+N9FaYgmRDhgVKYiRq4Ghw+3x4FojTZswxF79l4/hNgSrrsOb7f4kadn3E8hGuVzML2/+qavFs2wCIQHzpenBsa6G6MypKRUkLDPckwr6twFLd4+yX6FxpcpvMJwGLAA/WvBzB8yqRGZXWxNK9FSZ/g8wxkkF0BTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dUE/+jbm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G80lCqoU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:47:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1TygZpbyYm0j4DNXH/yYydCHYeinoKRtxGI+IH64xs=;
	b=dUE/+jbmOvUs0DFnXCwIBApUKGCpGjiB9ju3VlL/apzvinLVYu4306u1G/iShlHa8aew2X
	4615YuHxb+Ncz4hbGEfqqxoUF9AkS9iDnIMOielu6t4We7Ol/Y9g4+snkRpojRks5p20zz
	KkmXaQjydRdMcd+Yg8WwmMHUmH2kyTqZNd91Th0U8sdjYmXU33VX+qQnWZUGXKe+t8gL50
	RDS8Q+/WFD4Bx5ssY/KnRJLdB/oU6XD6xbTAv37pf52rBcDcS4kbswjJ8i+ee8e0iNNUlW
	9eQQ/ePHWk35tysCFJV7jCrRXRdqC8DCuWxC2u4WjdvJzEf1egZY7S/OpC7I/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C1TygZpbyYm0j4DNXH/yYydCHYeinoKRtxGI+IH64xs=;
	b=G80lCqoUozPnNVWlbDz3qh84Zp9kS82zGDERISs/VSmPC/f8eJvXhwJlOXDq8zfQf/Pmna
	LPzoJ6l5/dX7RxCQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] <linux/sizes.h>: Cover all possible x86 CPU cache sizes
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-31-darwi@linutronix.de>
References: <20250304085152.51092-31-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108165299.14745.5733415533323964838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     0d22030c49bfb2bd86ffa55c474f5f23b55e0533
Gitweb:        https://git.kernel.org/tip/0d22030c49bfb2bd86ffa55c474f5f23b55e0533
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:41 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:34:16 +01:00

<linux/sizes.h>: Cover all possible x86 CPU cache sizes

Add size macros for 24/192/384 Kilobytes and 3/6/12/18/24 Megabytes.

With that, the x86 subsystem can avoid locally defining its own macros
for CPU cache sizes.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Link: https://lore.kernel.org/r/20250304085152.51092-31-darwi@linutronix.de
---
 include/linux/sizes.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/sizes.h b/include/linux/sizes.h
index c3a00b9..4903949 100644
--- a/include/linux/sizes.h
+++ b/include/linux/sizes.h
@@ -23,17 +23,25 @@
 #define SZ_4K				0x00001000
 #define SZ_8K				0x00002000
 #define SZ_16K				0x00004000
+#define SZ_24K				0x00006000
 #define SZ_32K				0x00008000
 #define SZ_64K				0x00010000
 #define SZ_128K				0x00020000
+#define SZ_192K				0x00030000
 #define SZ_256K				0x00040000
+#define SZ_384K				0x00060000
 #define SZ_512K				0x00080000
 
 #define SZ_1M				0x00100000
 #define SZ_2M				0x00200000
+#define SZ_3M				0x00300000
 #define SZ_4M				0x00400000
+#define SZ_6M				0x00600000
 #define SZ_8M				0x00800000
+#define SZ_12M				0x00c00000
 #define SZ_16M				0x01000000
+#define SZ_18M				0x01200000
+#define SZ_24M				0x01800000
 #define SZ_32M				0x02000000
 #define SZ_64M				0x04000000
 #define SZ_128M				0x08000000

