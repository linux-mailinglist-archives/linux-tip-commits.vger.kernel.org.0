Return-Path: <linux-tip-commits+bounces-8076-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 952F1D3C5E3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jan 2026 11:47:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0496C588BD7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Jan 2026 10:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A73F0745;
	Tue, 20 Jan 2026 10:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QgTpPZsk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="10MDeHPx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92922C11ED;
	Tue, 20 Jan 2026 10:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768905068; cv=none; b=AifUfv/NC5S89mG8N0Pi13Nxvicr1h6rksrjBWQskXhfK6GVpA/IgEr3VEMjdyqHTv4DaO9dw7fjwqhyVVxRJUkswer7Xg/Xh0qX2arkXNvp9fTwzjFis++L4scD7gV5nySoEeXoo3rhmNst180+qPjFmFhne5u1ft6u9xWkwSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768905068; c=relaxed/simple;
	bh=B1EF2CDic5R5ADtR6dUqPMRKLx6qotqlzKJXiOjz4iU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=flIw+JgrbJ/yVBNfYZBV/z9cF1KRE/3R8wRBkPmiH39hkJltMEAeGCBJ7x6pEGNZ2S98aAYp3t9iMBuhVkoF7PxHKzzdGgzQwL6rgbzuyCmvPocM8T8SRyJRfhUWYsfJ3pVz+VT9aL5A+eW4fkjjtsSTb/qFX9xTW0GdSWRMV4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QgTpPZsk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=10MDeHPx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Jan 2026 10:30:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768905062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7BZ8F2nhj1P0qQiVuS4cuOCq5+UVDN87HLMgxod0vlA=;
	b=QgTpPZskwNg76/kV4ffJaJL4UXhm4hkzKcXecjUYupmkUi2x1j2o9+bkPKgO0XFfKOOeK8
	hABiIFWYtL+AIIOevqb+2OoSpU2eYoMr8ge3305YLLTHWAMja/oFyxGL4w4xeVQ+8okV69
	Ki2xJW40hDQ2gJ0EnWCqjVfS3vXw/0136hnG2HjyDgNrp/lGGQETLOYlSF4YYwdS8reBuY
	yYFbWO6qsbwzZfT0WfYXWaVKY8lF8JpG8EsUDeKyR2zNerrC0dPUg+KCRMAGIsyuW2gQKP
	wS9EJsMNmANmson5jPkUSP7qc+jRaGmsYQFj1RqBNl8Ed+XCWE0zQ6+avu74ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768905062;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7BZ8F2nhj1P0qQiVuS4cuOCq5+UVDN87HLMgxod0vlA=;
	b=10MDeHPxxEtkTYpLy9bOqv5Pwd6bd0dl2UUEmcTWneMuQlB8cJuNHabv+hfMgk7aBUrgrM
	HoUyQCWXD8hEfPAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Use kfree_sensitive() when freeing a SNP
 message descriptor
Cc: kernel test robot <lkp@intel.com>, Julia Lawall <julia.lawall@inria.fr>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260112114147.GBaWTd-8HSy_Xp4S3X@fat_crate.local>
References: <20260112114147.GBaWTd-8HSy_Xp4S3X@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176890506111.510.12355221594029058279.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     af05e558988ed004a20fc4de7d0f80cfbba663f0
Gitweb:        https://git.kernel.org/tip/af05e558988ed004a20fc4de7d0f80cfbba=
663f0
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 12 Jan 2026 12:37:49 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 20 Jan 2026 11:23:28 +01:00

x86/sev: Use kfree_sensitive() when freeing a SNP message descriptor

Use the proper helper instead of an open-coded variant.

Closes: https://lore.kernel.org/r/202512202235.WHPQkLZu-lkp@intel.com
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://patch.msgid.link/20260112114147.GBaWTd-8HSy_Xp4S3X@fat_crate.lo=
cal
---
 arch/x86/coco/sev/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index a059e00..1b86f48 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -1632,8 +1632,7 @@ void snp_msg_free(struct snp_msg_desc *mdesc)
 	free_shared_pages(mdesc->request, sizeof(struct snp_guest_msg));
 	iounmap((__force void __iomem *)mdesc->secrets);
=20
-	memset(mdesc, 0, sizeof(*mdesc));
-	kfree(mdesc);
+	kfree_sensitive(mdesc);
 }
 EXPORT_SYMBOL_GPL(snp_msg_free);
=20

