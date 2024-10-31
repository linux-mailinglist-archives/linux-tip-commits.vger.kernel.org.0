Return-Path: <linux-tip-commits+bounces-2680-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D98D29B8552
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 22:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2985D1F2122C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 21:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9018C1BB6B5;
	Thu, 31 Oct 2024 21:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QhtNsCRH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bOcjglYi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF049191F75;
	Thu, 31 Oct 2024 21:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730410190; cv=none; b=USwHa51C3XwGLCtR1WQUgpSfTKpq/lfzIY+jehCv9RpDBflc6XBKB8wqAwBy+X4k3tEh4v0BCITQbZGOvv+84knC/LEryWGklz/2Qu35Vlrq5FPvrU44tuwRY9ANKXI1a4xVzOgNr42F5sa2AoKB8+AdfDmjLeYyoTHwZD11yss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730410190; c=relaxed/simple;
	bh=589utcvkyDxyuBMAc8Mf7dvjinwf6JwPAEFN2hpJS1E=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=SxKaDDGCGa5n5uvxOUtWPkxCkSjDMqocxs1KxZXnh3LpvkQPUJ/2EM3/sEsmtKMA6vcoJaEWNWHNPiXaA99RAsID8zpB9tU+Fc6Nm62+Czis1FKxPIV8OEX6rKUu0FFavMSBcXUwoK75OK0DIrkdthQcqyTH+iMK2gV8s1jpp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QhtNsCRH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bOcjglYi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 21:29:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730410182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ev9NuHbNnzI7UMT0gR+ixomJ2zAfEQRvtPYb39v/gD8=;
	b=QhtNsCRHvbA+nl+np8bQBs9LTmQN4Xh/SUed7FC8UVkfcc0MUWecn9d/dnaWn/qcbobxur
	W2aejv1ED19o5uREcDQvHcTzyQgoVTcvmp8yuEA2EOipkNCg0bHBY1aHfxJGFDOBRwLQ/p
	MNj+5/RGdVl4G47ISpyfOko+C2ZG0QZxbD2s7d21BIAEuMiPiDBjARMCBAxnPc7R3wseD4
	qmZv6RBQhYkE5VPx0l6kXsZfD/npPbVRdW0/cTwMo13pe5OwUrEFqP5zOx5QDA4VYHns+S
	8ul17UL6T+0SW0ZGeIMvkAv3ZnN0Nrpg/AHrteeN48hMTBrLDujGUovXHPw5Bg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730410182;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ev9NuHbNnzI7UMT0gR+ixomJ2zAfEQRvtPYb39v/gD8=;
	b=bOcjglYinYXaUQgnEUNviBscRQT7X1RUwkyUN50NDvTOFKWwd4W6ZKVEPuThyU8ggKcHBF
	hHbRcDeCsb5ae4DQ==
From: "tip-bot2 for Carlos Llamas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] Revert "scripts/faddr2line: Check only two
 symbols when calculating symbol size"
Cc: Carlos Llamas <cmllamas@google.com>, Will Deacon <will@kernel.org>,
 Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173041018168.3137.3502030202992505729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     56ac7bd2c58a4e93d19f0ccb181035d075b315d3
Gitweb:        https://git.kernel.org/tip/56ac7bd2c58a4e93d19f0ccb181035d075b315d3
Author:        Carlos Llamas <cmllamas@google.com>
AuthorDate:    Mon, 12 Aug 2024 23:01:20 
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Thu, 17 Oct 2024 15:16:04 -07:00

Revert "scripts/faddr2line: Check only two symbols when calculating symbol size"

This reverts commit c02904f05ff805d6c0631634d5751ebd338f75ec.

Such commit assumed that only two symbols are relevant for the symbol
size calculation. However, this can lead to an incorrect symbol size
calculation when there are mapping symbols emitted by readelf.

For instance, when feeding 'update_irq_load_avg+0x1c/0x1c4', faddr2line
might need to process the following readelf lines:

 784284: ffffffc0081cca30   428 FUNC    GLOBAL DEFAULT     2 update_irq_load_avg
  87319: ffffffc0081ccb0c     0 NOTYPE  LOCAL  DEFAULT     2 $x.62522
  87321: ffffffc0081ccbdc     0 NOTYPE  LOCAL  DEFAULT     2 $x.62524
  87323: ffffffc0081ccbe0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62526
  87325: ffffffc0081ccbe4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62528
  87327: ffffffc0081ccbe8     0 NOTYPE  LOCAL  DEFAULT     2 $x.62530
  87329: ffffffc0081ccbec     0 NOTYPE  LOCAL  DEFAULT     2 $x.62532
  87331: ffffffc0081ccbf0     0 NOTYPE  LOCAL  DEFAULT     2 $x.62534
  87332: ffffffc0081ccbf4     0 NOTYPE  LOCAL  DEFAULT     2 $x.62535
 783403: ffffffc0081ccbf4   424 FUNC    GLOBAL DEFAULT     2 sched_pelt_multiplier

The symbol size of 'update_irq_load_avg' should be calculated with the
address of 'sched_pelt_multiplier', after skipping the mapping symbols
seen in between. However, the offending commit cuts the list short and
faddr2line incorrectly assumes 'update_irq_load_avg' is the last symbol
in the section, resulting in:

  $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
  skipping update_irq_load_avg address at 0xffffffc0081cca4c due to size mismatch (0x1c4 != 0x3ff9a59988)
  no match for update_irq_load_avg+0x1c/0x1c4

After reverting the commit the issue is resolved:

  $ scripts/faddr2line vmlinux update_irq_load_avg+0x1c/0x1c4
  update_irq_load_avg+0x1c/0x1c4:
  cpu_of at kernel/sched/sched.h:1109
  (inlined by) update_irq_load_avg at kernel/sched/pelt.c:481

Fixes: c02904f05ff8 ("scripts/faddr2line: Check only two symbols when calculating symbol size")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/faddr2line | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/faddr2line b/scripts/faddr2line
index fe0cc45..1fa6bee 100755
--- a/scripts/faddr2line
+++ b/scripts/faddr2line
@@ -252,7 +252,7 @@ __faddr2line() {
 				found=2
 				break
 			fi
-		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2 | ${GREP} -A1 --no-group-separator " ${sym_name}$")
+		done < <(echo "${ELF_SYMS}" | sed 's/\[.*\]//' | ${AWK} -v sec=$sym_sec '$7 == sec' | sort --key=2)
 
 		if [[ $found = 0 ]]; then
 			warn "can't find symbol: sym_name: $sym_name sym_sec: $sym_sec sym_addr: $sym_addr sym_elf_size: $sym_elf_size"

