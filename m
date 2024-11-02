Return-Path: <linux-tip-commits+bounces-2748-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328E59B9FC3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC120281AA1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7859D1B3956;
	Sat,  2 Nov 2024 11:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4fcOD5Ff";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VsWoz4sN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31E01B21A6;
	Sat,  2 Nov 2024 11:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548234; cv=none; b=KtZXGbEi68gD1Hrt0BbCHmDOqUXQy33vQIKRxydH9Ux4E+gfP3dEVWYcR6q0kQkK0+KNFPENQnpijZw3mu71/1oG66X9C0j4x3HkTX44ejbW+qKH469MB5UY+xWAjmQFPjGSvMIuIi3Xr/5+GSPjJxSkSSfnMFgg6m8chKdymnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548234; c=relaxed/simple;
	bh=pvuUQC4AfXw+ch0Uu7yxIeJsSlMo4cci6b8Cl7v8m0I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MVf7iKwTIgDWWLkD8wJwlt7W3ZvP3tFibwoAur7+bNbBYHYSpgefZ/nZ/m3t6q2WBRx6XArCIajlEGjpwYLkWcoyj9UHif7BkX2qtA2VyMG5ZVFqlYvy+puz5ifxLeJ1kNLSErq5InOf8MzYFllQtt/N4OsP+nhG87cvtP0jvXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4fcOD5Ff; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VsWoz4sN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csXGZ4kQuT1wD/4F8PCURbLXVevWLLkeu5Qi2iHNqRE=;
	b=4fcOD5FfF8DdJUFZoAunth/1YY8bEFgiBuV1nOBGp3Qy3LyftGGkJAkoui95OBRpYGw4Gm
	BJwC/u+rt6fyC0St9yb3ksXsva1I4iGrDWUEnuIOU7ZHxSLZwN1uMs1tU8v0UcYA7oq8hO
	85dcjuXOOB356jensVVD1CQidQFT1tfU3w/HwcRSGQISnHaZVD/r2fd8cl15GtT6HJ35Qw
	0uqZbjgB179LbPhVqczpMlsra5ANcxNvVENnwved7jmGf+npqvwzYBMG7XDu+sqc1Hx7gJ
	WjO4WnclaBJ+DWNVUTEROHT98twrzqomnex896IX9q/uOs+RSOffqKExVCUgRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=csXGZ4kQuT1wD/4F8PCURbLXVevWLLkeu5Qi2iHNqRE=;
	b=VsWoz4sNhnVvRxN6vbIapzJGPv1a1RArBX3JobyA3l/v1RC14aGpGnas7/SwplWuuL1BTv
	cTSjFInv5KAMSnBA==
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
Message-ID: <173054823036.3137.6939222171646461860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ff435493d67a2ca7b7be88c3feeca52893790391
Gitweb:        https://git.kernel.org/tip/ff435493d67a2ca7b7be88c3feeca528937=
90391
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:32 +01:00

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

