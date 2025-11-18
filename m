Return-Path: <linux-tip-commits+bounces-7389-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0FAC69F54
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 15:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 55B702B9D2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 14:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CB9C35C19E;
	Tue, 18 Nov 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WAMJs5dm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VEpMU5fF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A383563D3;
	Tue, 18 Nov 2025 14:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476123; cv=none; b=YXePRKy+rolzJfDCP9NrKEtsf7uqXcqP8bPkGy4wNHxPjFTB0MwolwBDsJEW6u1lBYdI5YJU42KSPY+9ITpiRi+EB627z9DCC52Ga7pCidhCd7692grIv2dNecyHMpodTCKtUTroldrdJ9pebM8txaGDBJCNObmr9Sr482s6ceQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476123; c=relaxed/simple;
	bh=pR4pAjuYl34mtWtmDEBPyEwIJwe+40/e6Sxyk2nLYAA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LDrm1A6WKhj8K7CFjjVBBVfvZprVC614yKIdGae3czEUAN5ke1bmAsmO/DGCSXhnB/Dn3oCclKTubbLxL3DtBEVGgEGa1uEK1fpDZ5KyWWYm2LiZFrrUNd3ohYjgmbIzsa5kKhcEzgc6jxloWTvL2ljrcLG+3eEA2HyajQoU9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WAMJs5dm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VEpMU5fF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 14:28:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763476119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrIJ84VjmhqyyvJApBq1pdhJ8u/oyhez1vJJ1rOTj2o=;
	b=WAMJs5dmDnAFKWcoLbCvz27R49h9NmT98UZEkS3JWBo/ty3p/8XAB/EmLlnuCD5CwUP2eA
	NvTh274Ue9d0OG3fU7UtIQ6AhZ5+6tEInaRVFY07yJDdb1hDGrfBh2FYH4ITOWTuQ9UkyP
	jzj5cINxUL/anSUTEVUU9tF4rf5r+uHfyM2nKfp+FEmMMi1s4pL+LpTFoxLzDzvIKP5MdP
	G9Bs/VzZLhIqOmd27PVarF6SMu53p3HFB6yPu9z/8SNsb0GOf2B3Ou65Y/aQcNrc+ycK+k
	8L0S1g1a/SUXTr2uNpl9D7wI6O3rHVivOT+3j4fCBEdgOsfB3iPZcKEertcOhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763476119;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qrIJ84VjmhqyyvJApBq1pdhJ8u/oyhez1vJJ1rOTj2o=;
	b=VEpMU5fFNlWHTaB90T+Qz5uCT4IS503LiDHYhalSO5eDPv7pQMNt9LXvQRf0MMJDcdQheo
	9PEeu4/+DvCtaqAQ==
From: "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/uaccess] iov_iter: Add missing speculation barrier to
 copy_from_user_iter()
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6b73e69cc7168c89df4eab0a216e3ed4cca36b0a=2E1763396?=
 =?utf-8?q?724=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
References: =?utf-8?q?=3C6b73e69cc7168c89df4eab0a216e3ed4cca36b0a=2E17633967?=
 =?utf-8?q?24=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176347611805.498.14857756863113145675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/uaccess branch of tip:

Commit-ID:     803abedbd540617f136a2c4d7066ff2e304f016d
Gitweb:        https://git.kernel.org/tip/803abedbd540617f136a2c4d7066ff2e304=
f016d
Author:        Christophe Leroy <christophe.leroy@csgroup.eu>
AuthorDate:    Mon, 17 Nov 2025 17:43:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Nov 2025 15:27:34 +01:00

iov_iter: Add missing speculation barrier to copy_from_user_iter()

The results of "access_ok()" can be mis-speculated.  The result is that
the CPU can end speculatively:

	if (access_ok(from, size))
		// Right here

For the same reason as done in copy_from_user() in commit 74e19ef0ff80
("uaccess: Add speculation barrier to copy_from_user()"), add a speculation
barrier to copy_from_user_iter().

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/6b73e69cc7168c89df4eab0a216e3ed4cca36b0a.17633=
96724.git.christophe.leroy@csgroup.eu
---
 lib/iov_iter.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index a589935..896760b 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -49,11 +49,19 @@ size_t copy_from_user_iter(void __user *iter_from, size_t=
 progress,
=20
 	if (should_fail_usercopy())
 		return len;
-	if (can_do_masked_user_access())
+	if (can_do_masked_user_access()) {
 		iter_from =3D mask_user_address(iter_from);
-	else if (!access_ok(iter_from, len))
-		return res;
+	} else {
+		if (!access_ok(iter_from, len))
+			return res;
=20
+		/*
+		 * Ensure that bad access_ok() speculation will not
+		 * lead to nasty side effects *after* the copy is
+		 * finished:
+		 */
+		barrier_nospec();
+	}
 	to +=3D progress;
 	instrument_copy_from_user_before(to, iter_from, len);
 	res =3D raw_copy_from_user(to, iter_from, len);

