Return-Path: <linux-tip-commits+bounces-4464-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 33D22A6EBC0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E321894F2F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:37:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C079257AEC;
	Tue, 25 Mar 2025 08:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jWQFAQCN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cpK4gYNe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C14E257425;
	Tue, 25 Mar 2025 08:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742891713; cv=none; b=otchPzWbGLnWYP3iVTkYYHgV2ISJvraVXTYKARcCB8SglAHYndOUu5vIBhPRpPn/w1jYvDeg4xxg9JeYbg6nex45FwVyDnJrXHjCLC1ZLwSd7IHzE0ZzOHBnOIeR57uS7SosrZCgV72SJUrAlhUXnE56zpaLvxm7HxwO5cn1SzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742891713; c=relaxed/simple;
	bh=sGWgKFS19lApaaQVjKhRLjj5L+UPSlrSbkfq9RyQZAU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z20poUoPwfCEVkKbnq+5NRV4HmPVjcx7OfxBjZmVdGOnQkC2/xiJ3lI0EUHHtTrDdwNAYDbz3UYXAcu+YhTMNNc2ECzkC5s0TAcjqbhATEctsxrdoEJC0+MIVwJg4EnII/z6fGmXaQNLwRVcV/AbeMyTzYAcWRs7vtFlWaz0OHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jWQFAQCN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cpK4gYNe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:35:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742891709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXWdLNiFqjcJy8RDdZyi+igNyxV9zlyuc3/D+OV9ryo=;
	b=jWQFAQCNIp135UhzIlNwR3la5vPOuPg3c0rG4ckdegIP1fr/uY2f1/e3ApcEWELi3nxtgp
	P6VX33qF2jdnRTH7sa4szPy3JoTbrFfd6d9etqWENAn5p2X6vP0RoPVx0rXIQ5n7v3Tkj8
	UDUToSyyW6o67NzORkk4S8Zio1varYJ7pmxRBQyGdXnCUmrf3LuYjgbEyvCrM5P53dLRP6
	kNQXHEZRU6Wy3+Y0W1fVWKh1Yb8CgMrH6qkcaLsiIpHQc3E4fm9C72ZLhBcBf58XMYGegy
	f95hGkRokOD0y9Ia751KZ99Hwktt2+bX4+JGOXvKmouPMDfCeXw8KU3R/jvwvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742891709;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lXWdLNiFqjcJy8RDdZyi+igNyxV9zlyuc3/D+OV9ryo=;
	b=cpK4gYNeL1gRmBK2aGTuWNQdoSC6U+MrXBt+Xopn2tF7ecB7MWMI8tOhjp0N2mPzO2eCoz
	PVVBdjJuN1CloeAQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/urgent] objtool: Fix CONFIG_OBJTOOL_WERROR for vmlinux.o
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <4f71ab9b947ffc47b6a87dd3b9aff4bb32b36d0a.1742852846.git.jpoimboe@kernel.org>
References:
 <4f71ab9b947ffc47b6a87dd3b9aff4bb32b36d0a.1742852846.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289170883.14745.15615696058250224080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     4759670bc3e670069c055c2b33174813099fea4f
Gitweb:        https://git.kernel.org/tip/4759670bc3e670069c055c2b33174813099fea4f
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 24 Mar 2025 14:55:55 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 09:20:26 +01:00

objtool: Fix CONFIG_OBJTOOL_WERROR for vmlinux.o

With (!X86_KERNEL_IBT && !LTO_CLANG && NOINSTR_VALIDATION), objtool runs
on both translation units and vmlinux.o.  With CONFIG_OBJTOOL_WERROR,
the TUs get --Werror but vmlinux.o doesn't.  Fix that.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/4f71ab9b947ffc47b6a87dd3b9aff4bb32b36d0a.1742852846.git.jpoimboe@kernel.org
---
 scripts/Makefile.vmlinux_o | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 0b6e2eb..f476f56 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -30,12 +30,20 @@ endif
 # objtool for vmlinux.o
 # ---------------------------------------------------------------------------
 #
-# For LTO and IBT, objtool doesn't run on individual translation units.
-# Run everything on vmlinux instead.
+# For delay-objtool (IBT or LTO), objtool doesn't run on individual translation
+# units.  Instead it runs on vmlinux.o.
+#
+# For !delay-objtool + CONFIG_NOINSTR_VALIDATION, it runs on both translation
+# units and vmlinux.o, with the latter only used for noinstr/unret validation.
 
 objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 
-vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
+ifeq ($(delay-objtool),y)
+vmlinux-objtool-args-y					+= $(objtool-args-y)
+else
+vmlinux-objtool-args-$(CONFIG_OBJTOOL_WERROR)		+= --Werror
+endif
+
 vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
 vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr \
 							   $(if $(or $(CONFIG_MITIGATION_UNRET_ENTRY),$(CONFIG_MITIGATION_SRSO)), --unret)

