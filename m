Return-Path: <linux-tip-commits+bounces-7924-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C407CD1837F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 635A030209BE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0F438E134;
	Tue, 13 Jan 2026 10:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s6nVZm2I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bL3grXtK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A759E38B7A2;
	Tue, 13 Jan 2026 10:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768301402; cv=none; b=PDT89ed3G/8U5XL/f6YjPftGRW+XPeOy+fVeGB+ZmC5R642IccU1cyh4ZWuOvUiAomqGwJE5gl0RC//Ggt0CsBJ3DzaJ8qal5hQqbUWrybfjSdDgpzu1uWaCYr4OLC0fsGXXjRUQ3jxx6XfN9GIjGDRU6wTv0G8ilIlPum8zH9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768301402; c=relaxed/simple;
	bh=qJ9nDC/MGZbi0ZbtVtD/p9eRf1X84NIDdqmyMpnpEEo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gFsRLE/DAahHNmbLc98nfMPr0IqM1KkITsJEOSlCxz1UvlNLqknF+spXSWBJd5gGDwm8h0Bj3nzDJiWVOb5Z7+6cAwazokhThdNS9H/UQfCeEmGvs/f7gfkPszUXgjw6VYLGiOJ0C/ShdV5dukwCXdsdEBsKHJABY8072DbTmyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s6nVZm2I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bL3grXtK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:49:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768301398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XG+ByXswHwIb8r4PbgEPRPSQGB6zfXPcPKQGgHrH9E=;
	b=s6nVZm2I6/ShijGObxZT44dZ90RjnPRh5YX7dFYueAx1JRgl2QCnyyTC/uh7QpWO2dZP65
	qKvDeD7NtsEF7N10tvN9YhddTVzKRHRM0LPNy2W3NEOygYCUpWnpGMfUAHqMDcsrZS/gZq
	tJIwveLr85SotIj9FzOdcjZnuxshoa9hilJ9TvSamA/N3RG6zF8hChGDGDdec7mOwdwLV6
	41zJqz5B9dY976NqVMcQZIISQ6+dRoZWqZPTy4+AZIsdMhRA37RzyGlw010169Pl7o7ETq
	J8Zy5KLKEbgC6tj2LqCw7nKpggNDIvuIt7F61VWMaMCbPikYnGggq0NgJOmjHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768301398;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7XG+ByXswHwIb8r4PbgEPRPSQGB6zfXPcPKQGgHrH9E=;
	b=bL3grXtK2JM/QtJlewTATSJm4ps6vtPOepyHy8WOO2L8ay+1uMAQQwQa26gTOuz6cRd7eL
	q02BRGGnWWs4NZCA==
From: "tip-bot2 for Boqun Feng" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/core] arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for UML_X86
Cc: FUJITA Tomonori <fujita.tomonori@gmail.com>,
 Richard Weinberger <richard@nod.at>, Boqun Feng <boqun.feng@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260106034034.60074-1-boqun.feng@gmail.com>
References: <20260106034034.60074-1-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176830139706.510.489304857404520372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cf4c3bc1445152c1949a4b5fef56d07579fadb1e
Gitweb:        https://git.kernel.org/tip/cf4c3bc1445152c1949a4b5fef56d07579f=
adb1e
Author:        Boqun Feng <boqun.feng@gmail.com>
AuthorDate:    Tue, 06 Jan 2026 11:40:34 +08:00
Committer:     Boqun Feng <boqun.feng@gmail.com>
CommitterDate: Fri, 09 Jan 2026 19:01:41 +08:00

arch: um/x86: Select ARCH_SUPPORTS_ATOMIC_RMW for UML_X86

x86 atomic instructions are used for um on UML_X86, therefore atomics
on UML_X86 support native atomic RmW as x86 does, hence select
ARCH_SUPPORTS_ATOMIC_RMW.

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
Acked-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Link: https://patch.msgid.link/20260106034034.60074-1-boqun.feng@gmail.com
---
 arch/x86/um/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/um/Kconfig b/arch/x86/um/Kconfig
index bdd7c8e..44b12e4 100644
--- a/arch/x86/um/Kconfig
+++ b/arch/x86/um/Kconfig
@@ -9,6 +9,7 @@ endmenu
 config UML_X86
 	def_bool y
 	select ARCH_USE_QUEUED_RWLOCKS
+	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select DCACHE_WORD_ACCESS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS

