Return-Path: <linux-tip-commits+bounces-4280-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F02BA64AE5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E10923B4EA0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B76C23909E;
	Mon, 17 Mar 2025 10:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fyiNwAiJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPbJbFz3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641D238141;
	Mon, 17 Mar 2025 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208395; cv=none; b=TR/bEDXLjYyuUaiK5JgCxeTOq+veefmLAdsGqe5zzUqRJP9wD5NHwGnsHla/q8cYQcxtleJeDXzgZulvja05TtIEDS4GAyEikWsLoFv0OwVJU7A7OXyOX/rhJq8+QtnVfM0vn/fCwss4LK0mi2rGwZivKaXxCInWfO6x22WwXRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208395; c=relaxed/simple;
	bh=0fRdMdBIAAtUMdw/vbdQ4bhoRFafsmrVvagZ8ioni0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z9fPz/l9LwfvsR4ACPk3p9aVCQcZw5bN6UAl326M9AaeVxxxUWHKxpXo/YaIqBBgPgTTusgBN8+9SyRtMfAoqLxNk5qMxxn4rUixQx4ds07UI9Ecc6t49vaFSN94c8Dp/fvk/uZODx7hmnOwK2AFL+PJQHTehavTgLTIlfeFjg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fyiNwAiJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPbJbFz3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsUPPA57gFUEZQeyNkQk2c4p5E87dxP5FIHlr6jaMsE=;
	b=fyiNwAiJJ81Ks3b9z6lpwg0qNX//ga6O2HpjoziB51qTlUmJlTSKYqv1xXlbmTj9OxyvBj
	mKHq1so8Hc+mzaHV94xqBIckA7DVqrm96PSZp/rsf6+ooHZ95C1SWKhKoGvUSyzOFypswh
	jWMV1QTahxW2TmF/ch2e1ORrt6rCNHfESDTIM8OGcMYgVaDnV+DG2zWDL328cD2qSPTTyc
	V3vHCwa9Ib9+Ozl1BEsy7UGJB+o3ln7NMcIRKHRheq/CkyvGRFaoOv8PT4S5nBOCwYyRJW
	s+oPWM2JTZ+6xWUnCSFQkzXhMsMk37Du4ZTuk1zE8wFv36awoFQE96lkb9z/9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lsUPPA57gFUEZQeyNkQk2c4p5E87dxP5FIHlr6jaMsE=;
	b=FPbJbFz3zABmE3qmpdQPdDxexyoFZyH5pc5wgr+lQT2Fw1vqUyznpknTKjI6X7w0vDu13B
	3tOJB5zdhGsOXlBQ==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Improve __noreturn annotation warning
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <ab835a35d00bacf8aff0b56257df93f14fdd8224.1741975349.git.jpoimboe@kernel.org>
References:
 <ab835a35d00bacf8aff0b56257df93f14fdd8224.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220839140.14745.6981725595927605919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     acae6b5bfffedc0440837c52584696dadb2fa334
Gitweb:        https://git.kernel.org/tip/acae6b5bfffedc0440837c52584696dadb2fa334
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:00 +01:00

objtool: Improve __noreturn annotation warning

Clarify what needs to be done to resolve the missing __noreturn warning.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/ab835a35d00bacf8aff0b56257df93f14fdd8224.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/Documentation/objtool.txt | 12 +++++-------
 tools/objtool/check.c                   |  2 +-
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/tools/objtool/Documentation/objtool.txt b/tools/objtool/Documentation/objtool.txt
index 7c3ee95..87950a7 100644
--- a/tools/objtool/Documentation/objtool.txt
+++ b/tools/objtool/Documentation/objtool.txt
@@ -319,14 +319,12 @@ the objtool maintainers.
    a just a bad person, you can tell objtool to ignore it.  See the
    "Adding exceptions" section below.
 
-   If it's not actually in a callable function (e.g. kernel entry code),
-   change ENDPROC to END.
+3. file.o: warning: objtool: foo+0x48c: bar() missing __noreturn in .c/.h or NORETURN() in noreturns.h
 
-3. file.o: warning: objtool: foo+0x48c: bar() is missing a __noreturn annotation
-
-   The call from foo() to bar() doesn't return, but bar() is missing the
-   __noreturn annotation.  NOTE: In addition to annotating the function
-   with __noreturn, please also add it to tools/objtool/noreturns.h.
+   The call from foo() to bar() doesn't return, but bar() is incorrectly
+   annotated.  A noreturn function must be marked __noreturn in both its
+   declaration and its definition, and must have a NORETURN() annotation
+   in tools/objtool/noreturns.h.
 
 4. file.o: warning: objtool: func(): can't find starting instruction
    or
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index e68a89e..d6af538 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4477,7 +4477,7 @@ static int validate_reachable_instructions(struct objtool_file *file)
 		if (prev_insn && prev_insn->dead_end) {
 			call_dest = insn_call_dest(prev_insn);
 			if (call_dest) {
-				WARN_INSN(insn, "%s() is missing a __noreturn annotation",
+				WARN_INSN(insn, "%s() missing __noreturn in .c/.h or NORETURN() in noreturns.h",
 					  call_dest->name);
 				warnings++;
 				continue;

