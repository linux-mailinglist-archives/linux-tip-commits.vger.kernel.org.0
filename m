Return-Path: <linux-tip-commits+bounces-7145-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E72C2870D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BA5874EF609
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC43330AD05;
	Sat,  1 Nov 2025 19:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kF2qY7Kb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XohvcPfP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB8E309EE4;
	Sat,  1 Nov 2025 19:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026474; cv=none; b=f1evlQ7KODXn+8PrkfUzuFdkKZsywx73p3l55pY2Ct3QUJH/mEofypp/dc8BkC0J/sk7fJKMosNL6cmHYIhUIGFf2kHWdUsEPi10SiVrDco0oLiFhZe1TTFcUH2EfEidlmLNK68WlkQ30riqewJxSVuMOi3VLQn/OWXFy2Jr5Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026474; c=relaxed/simple;
	bh=iPjc9d13ywrqwlmyRAi1DX6yoHRglkO3BBU4YPpWMsc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=R1rmjj5AUODVKIiMURDRqT0HX1BSEaVrhHkrtTZRfkJiGBqSpJbC/mDFrr9LuBeRz5eVKAN7mt0aO4Xr+/17ElJqtCqfZdluKloAkk4qZHhtRDTiWUGhMwlaWmZpTLWdcXVe83ep1PLKl/vZ2driXGrfuE6vpMu51pmfcx86GeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kF2qY7Kb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XohvcPfP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+hoXD0M66Y5eatoiorYspVCJwmK9h60fqROQ7tfIm8=;
	b=kF2qY7KbaXJfCSdScoc8/v1ebOpMz4eLu6AUJbvB+RSzjK/BHEt51bAq/yYvtEShMJDtZZ
	m0j4nuRLwhuFJBedwXb56IkaWqkuTGZVGeUcFiquyoG9A4JW50wKj75jW/rQYEqPqrTZP4
	MUbFcOlxBCKd5gCbkhqv/1eqSlzgh0zLn83UDCS6IjK/OPnK0K33KQoVnIgrAlsVpOoG8M
	QewQGEhaZTIRJDU6XCdg68RC8i59ivGOgAj1Tm2AwQ/900M+I34hXV7O42IXvL6w7TJfTN
	HMIHNMPaqAEGrEDthebJ52b0pQ+AUPYNvbWju1q1iFS4tacaj+fMeZiDX7wB2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026471;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b+hoXD0M66Y5eatoiorYspVCJwmK9h60fqROQ7tfIm8=;
	b=XohvcPfP4X3OlaqrikDfUxf9nMUhDmfwDKoQBUlMESSt+7uiGyg2r6i4QdXmJ9ddZra03e
	6tv+9JdoEQDNbtBQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/datastore: Reduce scope of some variables in
 vvar_fault()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-21-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-21-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202647042.2601451.17749396647983510251.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     5fd2a3424ce51df60deade50d5057177439c62b5
Gitweb:        https://git.kernel.org/tip/5fd2a3424ce51df60deade50d5057177439=
c62b5
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:07 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:06 +01:00

vdso/datastore: Reduce scope of some variables in vvar_fault()

These variables are only used inside a single branch.

Move their declarations there.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-21-e0607bf4=
9dea@linutronix.de
---
 lib/vdso/datastore.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index a565c30..2cca4e8 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -41,8 +41,7 @@ static vm_fault_t vvar_fault(const struct vm_special_mappin=
g *sm,
 			     struct vm_area_struct *vma, struct vm_fault *vmf)
 {
 	struct page *timens_page =3D find_timens_vvar_page(vma);
-	unsigned long addr, pfn;
-	vm_fault_t err;
+	unsigned long pfn;
=20
 	switch (vmf->pgoff) {
 	case VDSO_TIME_PAGE_OFFSET:
@@ -54,6 +53,9 @@ static vm_fault_t vvar_fault(const struct vm_special_mappin=
g *sm,
 			 * Fault in VVAR page too, since it will be accessed
 			 * to get clock data anyway.
 			 */
+			unsigned long addr;
+			vm_fault_t err;
+
 			addr =3D vmf->address + VDSO_TIMENS_PAGE_OFFSET * PAGE_SIZE;
 			err =3D vmf_insert_pfn(vma, addr, pfn);
 			if (unlikely(err & VM_FAULT_ERROR))

