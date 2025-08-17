Return-Path: <linux-tip-commits+bounces-6259-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ABCB29285
	for <lists+linux-tip-commits@lfdr.de>; Sun, 17 Aug 2025 11:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8078B204D4D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 17 Aug 2025 09:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7637F223337;
	Sun, 17 Aug 2025 09:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C2M/Z3NW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J5zJW4+S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965519463;
	Sun, 17 Aug 2025 09:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755424305; cv=none; b=K+qRH+fT8dFP44/yHRx3PwIIBsNcIZT9ka4T5vdNHZ1J1f3Tfegq0ev0m4nKkZf+orVcapMEq19fbCxR1t0i6TN63B048L6CtHrhUaH0BG86eV4qPqZnlnWiCEBhPguhQpy8ysqV149hiv0SSjn2kK7HVV+L5LGSbOYh0f7zSjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755424305; c=relaxed/simple;
	bh=mtJ3gzEv6o+xFkmPgKTzQ3JESw+W8iZciev1RKZWuSU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NtqlInoCEBBJXEbMxojax7R3dxoZzusmjB6TakVzOpHkQ9b13P7xmlJG6dZKTW8ve7sb5COON1pZj4jZ6S0XS47rpixAFKjGqWsKGCyrDBDYYYkRpVsHwdHJfUzG8ATp7KBOrOrH2wqMBvRjw3kZEoJBMmEnv+r9+kw1Ox++RDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C2M/Z3NW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J5zJW4+S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 17 Aug 2025 09:51:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755424296;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9HdNGuZyBv5MBuRLKD9Imf9j+MQbdgmcchbtdHA9ds=;
	b=C2M/Z3NWGm8uej/Xzl+D1xE0sFK+Wh6u10hUCJZon3mMkWkATvM+fZVjPFfcRAiSq7hj0T
	g/i1iP3C0iifIRQO4Yd7K8vX0a3d1bEv8K7PXfz5lQtlqfAXWjTcC7vkr+bR3TUWsjBaeB
	f2WSNSoPWPmKN245Wl5gAq5e0aDzWUUDzfiJw3NFpy02yj5gwrkfjic/mKxaZ9vY/cEh8Q
	2RLAZr0z4+XHvp452hLsC9qkoxID/antwj6aYlcn1bN4WYLgKVO/dRM+sxBdFpdoNmULxB
	bC+rp20xWWk4H4/THsLP46YqoqW7zqiUJn3t8KYOjvX9pGtxqpOaJHmQ383lBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755424296;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N9HdNGuZyBv5MBuRLKD9Imf9j+MQbdgmcchbtdHA9ds=;
	b=J5zJW4+SpgXZMsxgJhaNUYvrrWf3pgqwFxr+SIjz6y/zKdtsNYUZT2ukUEU2f5L5kGo7pO
	IUNupFDtnFwzkPDw==
From: "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Remove cc-option from -mno-fp-ret-in-387
Cc: Nathan Chancellor <nathan@kernel.org>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250814-x86-min-ver-cleanups-v1-4-ff7f19457523@kernel.org>
References: <20250814-x86-min-ver-cleanups-v1-4-ff7f19457523@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175542429414.1420.18313894506338628845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     0a42d732c136d3466cd19fafa7317d3004430318
Gitweb:        https://git.kernel.org/tip/0a42d732c136d3466cd19fafa7317d30044=
30318
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Thu, 14 Aug 2025 18:31:40 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sun, 17 Aug 2025 11:36:47 +02:00

x86/build: Remove cc-option from -mno-fp-ret-in-387

This has been supported in GCC for forever and clang gained support for it as
an alias of '-mno-x87' in LLVM 14. Now that x86 requires LLVM 15 or newer
since

  7861640aac52 ("x86/build: Raise the minimum LLVM version to 15.0.0"),

this flag can be unconditionally added, saving a compiler invocation.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://github.com/llvm/llvm-project/commit/a9fba2be35db674971382e38b99=
a31403444d9bf
Link: https://lore.kernel.org/20250814-x86-min-ver-cleanups-v1-4-ff7f19457523=
@kernel.org
---
 arch/x86/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 0c82a61..1bbf943 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -148,7 +148,7 @@ else
=20
         # Don't autogenerate traditional x87 instructions
         KBUILD_CFLAGS +=3D -mno-80387
-        KBUILD_CFLAGS +=3D $(call cc-option,-mno-fp-ret-in-387)
+        KBUILD_CFLAGS +=3D -mno-fp-ret-in-387
=20
         # By default gcc and clang use a stack alignment of 16 bytes for x86.
         # However the standard kernel entry on x86-64 leaves the stack on an

