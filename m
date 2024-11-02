Return-Path: <linux-tip-commits+bounces-2720-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0C109B9EBC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0243F1C20A70
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12C101ABEA7;
	Sat,  2 Nov 2024 10:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uFd7Vh8U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/OiYrjBR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EDA51A265B;
	Sat,  2 Nov 2024 10:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542224; cv=none; b=uRrXZpDr1Xb7HX+bg5hlWiLe/p5BTMeluqdFDs6V2/nP1/eY+gJugqY5vODrC0BqcqRlMIyfry/G3+djK01umulVe6Sv9zxLgSgwAVQdkysG9G3qD8/zQVh1ZtmmE58BbNQ59S5NNphQZ1acvIC4r1HCVxCXeiEQGt3q5G0qVhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542224; c=relaxed/simple;
	bh=06Fkn/6p0K/ZwNCWu+ZzwXucPIhmwspEmTEFaKKn2zI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JiHgG+iNWYtx0EwJWmw6Rfb/7Twdj+qTLCoINpL7JHeeqy8H6wm5DwlP9Lrj4XyWl0esXmNborsUd6SYbdRuUt9zTwKEr4eJflnWr5+JZ6EfJ76lR9/O5Ru8R1PyAmSDc6sGmQ+tdRtM1ZpuGUQfh1BArl1Pv22bXuN2iwVp6H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uFd7Vh8U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/OiYrjBR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gLdR1yGeHhBfdf2vEgIiHvUJIx2kdRAGMubf5GznxE=;
	b=uFd7Vh8U5sdW2kfPleupkNoESR7XKg1oEHalK1YK3spiJy8xMQh8a+LBEXohEAvQlAtsVi
	QgnZW4y+dLfrCYp7gHg0Y9o3gpCV0Cmv2nCB1wZhSIPuRiDHxJMisZInq3RqWsXiMWzRNN
	LJQVAwklhJZJjB/dORetZRBgF8U+pONA0e4dmorl8G+RyVkp9QBKUfedRBUzQYRu2ujk0n
	4pllki46q61/aWMUCMpxtwNSyP6jqG+DjydNspgqSaWGeMXqeb9Sky6SJGR4auDrWdzaXY
	7hy7zO/LrcLaxCePDwUX9149JuV61bhrfNWf0aP6Wjdv7/hzZsy9mtnVWYFgxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+gLdR1yGeHhBfdf2vEgIiHvUJIx2kdRAGMubf5GznxE=;
	b=/OiYrjBRUr6Uya1fPkUyj+h1zzj00ed+d2ZO35se3GMXJPn1/1tyEn6QhtGVD/zsKJBceY
	kaVEt5TeyTPWp1DQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] csky/vdso: Remove arch_vma_name()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-2-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-2-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221995.3137.11661848792611949837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     387cfb75eb3f0612aadf896450b0f5dabb9ca70f
Gitweb:        https://git.kernel.org/tip/387cfb75eb3f0612aadf896450b0f5dabb9=
ca70f
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:12 +01:00

csky/vdso: Remove arch_vma_name()

All callers of arch_vma_name() also get the name via vm_ops, which for
these VMAs will use the name from 'struct vma_special_mapping'.
Therefore the custom implementation is unnecessary and can be removed in
favor of the default implementation from kernel/signal.c.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-2-b64f0842d51=
2@linutronix.de

---
 arch/csky/kernel/vdso.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index 92ab8ac..c54d019 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -82,10 +82,3 @@ end:
 	mmap_write_unlock(mm);
 	return ret;
 }
-
-const char *arch_vma_name(struct vm_area_struct *vma)
-{
-	if (vma->vm_mm && (vma->vm_start =3D=3D (long)vma->vm_mm->context.vdso))
-		return "[vdso]";
-	return NULL;
-}

