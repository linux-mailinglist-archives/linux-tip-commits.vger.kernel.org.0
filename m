Return-Path: <linux-tip-commits+bounces-8041-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C8FD38E37
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 Jan 2026 12:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 701C83013EFB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 Jan 2026 11:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2488633509E;
	Sat, 17 Jan 2026 11:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gqOWzsZQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CpCUhkzD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B657C335081;
	Sat, 17 Jan 2026 11:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768649331; cv=none; b=MumQiGc1yJYMZa2PehqCfYMxGl25dqTMf1IMIQnCQqtGVuWLBJyLZf24haZkk9F1cn3V2fCPbKqqJRkv1FTsv7v1/fpTqjLgxlOf8+ApgR28IT5Tgt5/h7H7089WTf4SMvDHWhQYMwy0BZnG1woL8rKA7l3q6Yi2FT418Fmm/NQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768649331; c=relaxed/simple;
	bh=l15L6Xj2RL178e6Gln9qvSQDXaq1lu2J1UuyWGUaqKQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MBu2LWBEf+bBWLTBKuoKU04n7hSTKuF+CRn0EVjzxeAvkP04dyNpRuWRWhx/vhXVI54AQgk9ACK1qz+FeCMMCFynLsDqOf6sX1Pq4+ojrzpUpf1BWOT7/IIfqUZWa1QoBOyaJ0qEp7DrZ/pwGoxPzDKfujuhoTmpOOKdh6aa58U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gqOWzsZQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CpCUhkzD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 Jan 2026 11:28:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768649327;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uybnw4mSMag9Z565IHGYyteDB3r1j+uIBtBGcejuwfI=;
	b=gqOWzsZQyQssyNkA9qyvoM+wYgSuFzEmxdWz5isa+8zlIjYCUGSNIS+vpt/wuYlOKrCGWo
	TnU6zpF2ZR1wWx0AQH+E2lgGRr3avk9eKL8R2eJA0GiXFEGYSrljVV+8GiwFSRbsAtLnoq
	8cYM1irevq5WklXvx5mSaY0TmkDlZ41SlVM+gq5Ktmc7xb3rupG/DOdzhyLtTzpWECQ5Jn
	VkmoUyykjtL+sGfcx4gfj4ZLG5yFS9Whq/xN1dcRBZu8NxlzrnBK9MGVZfuxSP+tglhqOb
	q+B5W715mOIuvF7QzqEupCNEvKcZeLcy+Nin2YuausLmx0DhVTXIyiTm8GMIYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768649327;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uybnw4mSMag9Z565IHGYyteDB3r1j+uIBtBGcejuwfI=;
	b=CpCUhkzDZqyUNDAq0xsLXU67BIofE3kSk+CFub3I3UbvXFIeOZoL5QAsd7SMQR3OlrW2nB
	SHCm2Txynhf6oxDg==
From: "tip-bot2 for Bala-Vignesh-Reddy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] selftests/x86: Add selftests include path for
 kselftest.h after centralization
Cc: Linux Kernel Functional Testing <lkft@linaro.org>,
 "Bala-Vignesh-Reddy" <reddybalavignesh9979@gmail.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Anders Roxell <anders.roxell@linaro.org>,
 Brendan Jackman <jackmanb@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
References: <20251022062948.162852-1-reddybalavignesh9979@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176864931524.510.15949746634061180080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     d9b40d7262a227442bf402ea0708dc94f438bb52
Gitweb:        https://git.kernel.org/tip/d9b40d7262a227442bf402ea0708dc94f43=
8bb52
Author:        Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
AuthorDate:    Wed, 22 Oct 2025 11:59:48 +05:30
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 17 Jan 2026 12:22:27 +01:00

selftests/x86: Add selftests include path for kselftest.h after centralization

The previous change centralizing kselftest.h include path in lib.mk caused x86
selftests to fail, as x86 Makefile overwrites CFLAGS using ":=3D", dropping t=
he
include path added in lib.mk. Therefore, helpers.h could not find kselftest.h
during compilation.

Fix this by adding the tools/testing/sefltest to CFLAGS in x86 Makefile.

  [ bp: Correct commit ID in Fixes: ]

Fixes: e6fbd1759c9e ("selftests: complete kselftest include centralization")
Closes: https://lore.kernel.org/lkml/CA+G9fYvKjQcCBMfXA-z2YuL2L+3Qd-pJjEUDX8P=
Ddz2-EEQd=3DQ@mail.gmail.com/T/#m83fd330231287fc9d6c921155bee16c591db7360
Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
Signed-off-by: Bala-Vignesh-Reddy <reddybalavignesh9979@gmail.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Anders Roxell <anders.roxell@linaro.org>
Tested-by: Brendan Jackman <jackmanb@google.com>
Link: https://patch.msgid.link/20251022062948.162852-1-reddybalavignesh9979@g=
mail.com
---
 tools/testing/selftests/x86/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x=
86/Makefile
index 8314887..4340652 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -36,6 +36,7 @@ BINARIES_32 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_32))
 BINARIES_64 :=3D $(patsubst %,$(OUTPUT)/%,$(BINARIES_64))
=20
 CFLAGS :=3D -O2 -g -std=3Dgnu99 -pthread -Wall $(KHDR_INCLUDES)
+CFLAGS +=3D -I $(top_srcdir)/tools/testing/selftests/
=20
 # call32_from_64 in thunks.S uses absolute addresses.
 ifeq ($(CAN_BUILD_WITH_NOPIE),1)

