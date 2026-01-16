Return-Path: <linux-tip-commits+bounces-8038-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BCED388CF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 22:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7CEA300C35E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Jan 2026 21:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A174730AAD6;
	Fri, 16 Jan 2026 21:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Bcc3Nu/d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U/zAGkdQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F15308F1D;
	Fri, 16 Jan 2026 21:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768599987; cv=none; b=q9XOBySkQeLyzzvcvC5cyJ/0QMaIDsc2Ozot5C0eoGYceN7xjdTmaGqJYRpQO5gfrIUt+ZkXVOEFXH1EMIJuG64BBC/0tUEL9J4a6gbljWWCCqPuk9VzJzu3s+6yfO4BzR54J/PK2vUNcBGuO3ijGmlrKWi/rUjxXPqaR6IC+2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768599987; c=relaxed/simple;
	bh=PWTyWkRWlkPbUNt/3kWCK0TbyOkdm84L0iwxUdwGbR8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nI/1TKp3qhXK77XB26DIDq89oMuNaoMgHbI7x3Ig88/rauPBOPmSbVX6HxwHEbXWDa+JPLRpjT1uZS3Cqim1TYSV7zRCwNO87lsLpDKz1FJoMDKrCdRPKuo3J6AIdSfRvy+DhoUYEj77MRykvRWXoRcbWb/ImwSLvuDCAxjXLqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Bcc3Nu/d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U/zAGkdQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 Jan 2026 21:46:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768599981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0p/eoujaV0SCaVFn7gk3U3s7XksQg7S+oxq77dadols=;
	b=Bcc3Nu/dn+n1k0r+Pr7KqSUlg852Tt5ywgvOgemq10RfIVhVkLwnbomNnQWrBPitxj5Nws
	bDcWlg3fo1x/w1BJcG3ftMmM0PkjqjFKqYsQ72fDZva2+jhxiBj0WH+XNuOFGzXkoaKKsJ
	1/CwKo7WbMbO8cEq84I8a5sB5oDCorem8JuoTeXilAbL0gLH6zumaCOO8VNzxad74K+x2j
	XGLpyrxyi45cM/5C70r5tQnyr05btvY1R6w4bbQLjIvWPJ3zcojaobrJrEWvY3phsL7/5l
	PaiXm9PAZByhh/N03OjVuNxYDPLrk1Bo1KrbD1eNEudmc7x3+kilpNQB5rYjLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768599981;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0p/eoujaV0SCaVFn7gk3U3s7XksQg7S+oxq77dadols=;
	b=U/zAGkdQD/ENOf1rStgxB26/lm+0OLq3Pa/HtUn+JduqFgiinWJfQFgLi4xKBgVWGENbAC
	AKP0j36mvvW4ERDw==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/vdso/selftest: Update location of
 vgetrandom-chacha.S
Cc: kernel test robot <oliver.sang@intel.com>,
 "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260116204057.386268-4-hpa@zytor.com>
References: <20260116204057.386268-4-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176859998034.510.3755733365736555051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     db7855c96d4216b2ed45e2781fae9293b323c7ef
Gitweb:        https://git.kernel.org/tip/db7855c96d4216b2ed45e2781fae9293b32=
3c7ef
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Fri, 16 Jan 2026 12:40:56 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 16 Jan 2026 13:25:44 -08:00

x86/entry/vdso/selftest: Update location of vgetrandom-chacha.S

As part of the vdso build restructuring, vgetrandom-chacha.S moved
into the vdso/vdso64 subdirectory. Update the selftest #include to
match.

Closes: https://lore.kernel.org/oe-lkp/202601161608.5cd5af9a-lkp@intel.com
Fixes: 693c819fedcd ("x86/entry/vdso: Refactor the vdso build")
Reported-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://patch.msgid.link/20260116204057.386268-4-hpa@zytor.com
---
 tools/testing/selftests/vDSO/vgetrandom-chacha.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vDSO/vgetrandom-chacha.S b/tools/testing=
/selftests/vDSO/vgetrandom-chacha.S
index a4a82e1..10f9821 100644
--- a/tools/testing/selftests/vDSO/vgetrandom-chacha.S
+++ b/tools/testing/selftests/vDSO/vgetrandom-chacha.S
@@ -16,5 +16,5 @@
 #elif defined(__s390x__)
 #include "../../../../arch/s390/kernel/vdso64/vgetrandom-chacha.S"
 #elif defined(__x86_64__)
-#include "../../../../arch/x86/entry/vdso/vgetrandom-chacha.S"
+#include "../../../../arch/x86/entry/vdso/vdso64/vgetrandom-chacha.S"
 #endif

