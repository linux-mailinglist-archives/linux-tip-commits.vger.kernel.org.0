Return-Path: <linux-tip-commits+bounces-7641-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C60BFCB8791
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFD873099A11
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18CC431352E;
	Fri, 12 Dec 2025 09:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UtSYv0E9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pfPyqU7g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A776D313265;
	Fri, 12 Dec 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531756; cv=none; b=blTENqmxhx7QGa1src/6r26pHaDobadg9YihzCgXNaCFCPt9H8OC/Ytj1wnrs9xf9UlMSY85tn59Z4eODJz3hJL8ch5+GNRSpUlNjTEgL6rpn7U/mLyA03hMnz7ztQv30kBr3RSBHMk+g1UrkdZUQhrctylhH1AAeLkoBawqFRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531756; c=relaxed/simple;
	bh=H3n/bTHa60XQe23wxuD2OiJu9gDiPdD1PW4Ym0zHT+g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LsNjxr+0ROmyI1xA/jJZif8Xr3ab8HM4jtYE1UbKwvBYNgnxy7Ld7nncEamzCkFE6khFIU1pRe12/yA/ncPcFX8DNL9xGzBVaDWlt68o7GQPqvEhPHzVQBaaTe0bECcNBO4sOYHPm+Pfa0Wf21fwhARzW5jkDGuyfL+39DvjKzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UtSYv0E9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pfPyqU7g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:29:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765531751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+/YOBZwN6Nmo2T0ZuTBv5Yr+bAfTx9eJOZyT4oTB9o=;
	b=UtSYv0E9LA6jIXwixyJZJcFzDYEPqgKCsOPL5c6ew5FwRhOfSjzuUUtTp+s+uRdLP7SEvB
	QPcJSzq1JkFMA2+lu/sdkJEo9xBD4o/BBQ5p5/j7v/0CHfKWUQGQIal1RRaRI35yBpBbPf
	Gu9Jm2HhbKmmIIIr/WLlOYcEGt5tJ+3+Ayqmkymet4IkmAFExuQD+DRjIu8TWLMMNBoTo6
	LcXpzylZqugcZwic+D0sDFTo0HUlD1wkhjJBFnPac8hDG1bbCoyA+dbZTLGdyth7YDPDSv
	LUMrITkq5F7EO54kZnmypc3nLt/cHm6cJ1qDysBYHScAay0zic57AUmEk+KeeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765531751;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y+/YOBZwN6Nmo2T0ZuTBv5Yr+bAfTx9eJOZyT4oTB9o=;
	b=pfPyqU7g08EaxRqhG/LyeWsWjJO/NbbBiMrar3tocmqKLjS6HxGa9kwSNHJLtSIxsa8WT+
	jqNhhCwJrqKJ04Bw==
From: "tip-bot2 for Heiko Carstens" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] bug: Let report_bug_entry() provide the correct bugaddr
Cc: Heiko Carstens <hca@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251208200658.3431511-1-hca@linux.ibm.com>
References: <20251208200658.3431511-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176553175010.498.7313411575172995122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     b5e51ef787660bffe9cd059e7abe32f3b1667a98
Gitweb:        https://git.kernel.org/tip/b5e51ef787660bffe9cd059e7abe32f3b16=
67a98
Author:        Heiko Carstens <hca@linux.ibm.com>
AuthorDate:    Mon, 08 Dec 2025 21:06:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 10:26:13 +01:00

bug: Let report_bug_entry() provide the correct bugaddr

report_bug_entry() always provides zero for bugaddr but could easily
extract the correct address from the provided bug_entry. Just do that to
have proper warning messages.

E.g. adding an artificial:

  void foo(void) { WARN_ONCE(1, "bar"); }

function generates this warning message:

  WARNING: arch/s390/kernel/setup.c:1017 at 0x0, CPU#0: swapper/0/0
                                            ^^^

With the correct bug address this changes to:

  WARNING: arch/s390/kernel/setup.c:1017 at foo+0x1c/0x40, CPU#0: swapper/0/0
                                            ^^^^^^^^^^^^^

Fixes: 7d2c27a0ec5e ("bug: Add report_bug_entry()")
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251208200658.3431511-1-hca@linux.ibm.com
---
 lib/bug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/bug.c b/lib/bug.c
index edd9041..c6f691f 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -262,7 +262,7 @@ enum bug_trap_type report_bug_entry(struct bug_entry *bug=
, struct pt_regs *regs)
 	bool rcu =3D false;
=20
 	rcu =3D warn_rcu_enter();
-	ret =3D __report_bug(bug, 0, regs);
+	ret =3D __report_bug(bug, bug_addr(bug), regs);
 	warn_rcu_exit(rcu);
=20
 	return ret;

