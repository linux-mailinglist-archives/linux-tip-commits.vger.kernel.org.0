Return-Path: <linux-tip-commits+bounces-7956-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D139D1927A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 64C2F3014E85
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA86392B90;
	Tue, 13 Jan 2026 13:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HWsBv8pJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UgvLCapT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E26F39283A;
	Tue, 13 Jan 2026 13:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312067; cv=none; b=DHUcdsGGnZoN6a5kjUtop/7642q5XEMc9TCKSNSOfMcX9t9F6PeLDzg+LLGMCJIa5rmBsDwLKNtxzHpCGya8mpKJZeaT2bN9/RsRGLP0YBg8ub/zXCiKzq87R7OsPxEETpGc95efHULzRd1Fu4V7aUC9vb2uRIIki5XsnhKIqhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312067; c=relaxed/simple;
	bh=6Bh1Nom6ztKIoBVHY2MJCwP9fFDkdgnJrnvd5vcB6CA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kAOZxeLfLVDpx+dGkc6dRte2CC60Jel8j+gsSI/hN8KjrVBkLNwZJBY7g0AUtGaJI4+2kn4oJUvdeVajAkmEtPfD1RGEaWA9lxo4n517avBRlaUFdzvnYRlIHh0vgfR27q7dd5rX/vh5TXdBW3IDMPTkeIrtc8iHScucX2gMnQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HWsBv8pJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UgvLCapT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pV/Tj/7Bbq4e4DeSSkrFcGiIWJoSrlGNZClx8M0bwk=;
	b=HWsBv8pJ21z6zlOFvbe/XWqCCzdVXq2wls/uVgO9FJOTfaUl9SUjwatkoOS1vKZsEDNm4f
	DdU/vlLgEiM/0X/yCXHW4JoKSBpS7zXwWaRhoow4Vjesu5oENCsomk6kfaLAb+xgI9SMMc
	nf1eIFHHcF8B3TY3WVWYpQtHkuI4kQC/rmnrQDbdOgfFTqPOWfhRm6Ucp5F9H1QlEddxYn
	jcZhTlIjvL12KnFSlbv1oH1Vm0+NFYs+chBtP4v/14xuhcodvjf6x5aYChqa/pqWFmj0Nv
	+lX2O2jXxlu4ESYku9MFegGHf5mdvTD/S6SFCSK35iRGXcItzfPj5tgq26ljtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312061;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9pV/Tj/7Bbq4e4DeSSkrFcGiIWJoSrlGNZClx8M0bwk=;
	b=UgvLCapTs3QMmAiM1zdgnckEERHPPkGDSX/VU6p+H+cLJPO+iQec2xuxq+yorHHaN6l99J
	b+wUlfF2n2TGDzDw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_test_abi: Use UAPI system
 call numbers
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251223-vdso-compat-time32-v1-3-97ea7a06a543@linutronix.de>
References: <20251223-vdso-compat-time32-v1-3-97ea7a06a543@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205991.510.5977880468527402568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     1dcd1273add368c2b7c65135e22b416e1b374781
Gitweb:        https://git.kernel.org/tip/1dcd1273add368c2b7c65135e22b416e1b3=
74781
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 23 Dec 2025 07:59:14 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:23 +01:00

selftests: vDSO: vdso_test_abi: Use UAPI system call numbers

SYS_clock_getres might have been redirected by libc to some other system
call than the actual clock_getres. For testing it is required to use
exactly this system call.

Use the system call number exported by the UAPI headers which is always
correct.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20251223-vdso-compat-time32-v1-3-97ea7a06a543@=
linutronix.de
---
 tools/testing/selftests/vDSO/vdso_test_abi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vdso_test_abi.c b/tools/testing/sel=
ftests/vDSO/vdso_test_abi.c
index c620317..a75c12d 100644
--- a/tools/testing/selftests/vDSO/vdso_test_abi.c
+++ b/tools/testing/selftests/vDSO/vdso_test_abi.c
@@ -179,7 +179,7 @@ static void vdso_test_clock_getres(clockid_t clk_id)
 		clock_getres_fail++;
 	}
=20
-	ret =3D syscall(SYS_clock_getres, clk_id, &sys_ts);
+	ret =3D syscall(__NR_clock_getres, clk_id, &sys_ts);
=20
 	ksft_print_msg("The syscall resolution is %lld %lld\n",
 			(long long)sys_ts.tv_sec, (long long)sys_ts.tv_nsec);

