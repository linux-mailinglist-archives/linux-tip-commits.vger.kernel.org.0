Return-Path: <linux-tip-commits+bounces-7390-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 42877C69F5A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 15:28:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 477622BCCE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Nov 2025 14:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95E235C1B9;
	Tue, 18 Nov 2025 14:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CClhtIt5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K1qM05l7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CF3590AB;
	Tue, 18 Nov 2025 14:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763476124; cv=none; b=UfhWo8jketYGj9cwe1Nxh5vMP7FX8TJHSqPtv8aTpzYafAji9PEub7fDu0e0mX6tveXlRaZ1WVjvhiDtTKPGavVeXVkaTK3j29z4ZpNsp6I+JbHSZJQ6jV1TAUeDKKtSKqtq1x4VG34aaiACC/FC+ckt+mESaEfJ5y6iQnHQ814=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763476124; c=relaxed/simple;
	bh=pH8CeTzP0iy04V/orKIJXTvt4Hrfs0VmPN6rNkhJQqE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DOcb2EMQrB+N7N9ZpfLT6CQuvI6JkAxVYQNLGkZzLUk+OJIWKpJHjXjQUVRDvCczKbeE6pAkgtvtzKwoL3GW2upHFWqAWd8sRdSEm15vHCr/WS2VmPbem9q6UNT2TkKaw5qcyTrdDAzzIQehuoskTR2xkTokNg8AOkg0WVn7OnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CClhtIt5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K1qM05l7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Nov 2025 14:28:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763476120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7Cgn6OoycN/sDTRv83s2Dwl1kJds6ACdVLc5hWzf/k=;
	b=CClhtIt595BX/+xVU7UL7CEDsvCGc7gtX8CZoPJoMruvx0CIL+64rF64rZu+YA51nLV0qY
	YDjg6JrWEe3MnrCG0U/mQHUMEgyGbXil5AbjlfXcOgixjUgSAGTEQdPY33wYLPmPvlndTq
	XRtQc+qDPm7LKxf8sHVFeqyvYFcOVSas32PcMlqK1WrliaJq/gBEdcnnNYGaW1ko9FMD1o
	7TxElSRFkMN7NFSdOfXaHZ5nDLuCcLD65c10OPGBk4bIJFHD1+PLjhQiYiaZ6tpP+kFRJe
	37JQi4jubBNWG0Ofv2zRBkYHOwZEsWFO8VQuYkyhj38YOFrRWtyEL+nb1xABHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763476120;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b7Cgn6OoycN/sDTRv83s2Dwl1kJds6ACdVLc5hWzf/k=;
	b=K1qM05l7UlaCZWOPWroBDVdFYAwxJWo0Osws5u9du30RU/4jewLa32LcusfhDeSLWrOvXa
	r6LaEDyqK1BPeuBA==
From: "tip-bot2 for Christophe Leroy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/uaccess] iov_iter: Convert copy_from_user_iter() to masked
 user access
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C58e4b07d469ca68a2b9477fe2c1ccc8a44cef131=2E1763396?=
 =?utf-8?q?724=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
References: =?utf-8?q?=3C58e4b07d469ca68a2b9477fe2c1ccc8a44cef131=2E17633967?=
 =?utf-8?q?24=2Egit=2Echristophe=2Eleroy=40csgroup=2Eeu=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176347611905.498.2533319238035071763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/uaccess branch of tip:

Commit-ID:     4db1df7a7217827ee7f8a3414932e250f1ac2204
Gitweb:        https://git.kernel.org/tip/4db1df7a7217827ee7f8a3414932e250f1a=
c2204
Author:        Christophe Leroy <christophe.leroy@csgroup.eu>
AuthorDate:    Mon, 17 Nov 2025 17:43:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Nov 2025 15:27:34 +01:00

iov_iter: Convert copy_from_user_iter() to masked user access

copy_from_user_iter() lacks a speculation barrier, which will degrade
performance on some architecture like x86, which would be unfortunate as
copy_from_user_iter() is a critical hotpath function.

Convert copy_from_user_iter() to using masked user access on architecture
that support it. This allows to add the speculation barrier without
impacting performance.

This is similar to what was done for copy_from_user() in commit
0fc810ae3ae1 ("x86/uaccess: Avoid barrier_nospec() in 64-bit
copy_from_user()")

[ tglx: Massage change log ]

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/58e4b07d469ca68a2b9477fe2c1ccc8a44cef131.17633=
96724.git.christophe.leroy@csgroup.eu
---
 lib/iov_iter.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 2fe66a6..a589935 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -49,12 +49,16 @@ size_t copy_from_user_iter(void __user *iter_from, size_t=
 progress,
=20
 	if (should_fail_usercopy())
 		return len;
-	if (access_ok(iter_from, len)) {
-		to +=3D progress;
-		instrument_copy_from_user_before(to, iter_from, len);
-		res =3D raw_copy_from_user(to, iter_from, len);
-		instrument_copy_from_user_after(to, iter_from, len, res);
-	}
+	if (can_do_masked_user_access())
+		iter_from =3D mask_user_address(iter_from);
+	else if (!access_ok(iter_from, len))
+		return res;
+
+	to +=3D progress;
+	instrument_copy_from_user_before(to, iter_from, len);
+	res =3D raw_copy_from_user(to, iter_from, len);
+	instrument_copy_from_user_after(to, iter_from, len, res);
+
 	return res;
 }
=20

