Return-Path: <linux-tip-commits+bounces-7636-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E71CACB862B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA71E30069A6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DBC312801;
	Fri, 12 Dec 2025 09:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wPkQuy2r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RqQ6BTJG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47122311950;
	Fri, 12 Dec 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530645; cv=none; b=BaBR5dITEi1aeqnlLLZAqijB7EYrScq6yr4NkfGkeGTrrkDiflmUgeVRUaGQBqr97OJc48Y8HNNgRVi1O8gDZ9AmRKD6sqm+M6TIyfP2j15KCHxDDOqpTcmwGZxLDyI6oPE2yxNnLO1GWDH53myXCgrBdVSMGWqo8e+el+e1t/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530645; c=relaxed/simple;
	bh=oMGleHVyKRwCuo3aa9ZrOh1zHdX/ciMtAcA5hH7Hc9g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OSgNP8wIOYPNfV1nQhQFoWvvNWR/0k9ZoHP5A7W59O5mXqTBPYkdixCbJ3c429++Von+wq5qEQESxR8wNqnPwPVU0GWX6Uj0o0kw8whFwdFKmwiyXRILiopCb0nw/G9KcKU3FfvGBLvRd3KtD9frpvkSBO2bWw1o0tq2X7qrStY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wPkQuy2r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RqQ6BTJG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:10:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765530642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlp4bOzSrOeJXsyB8SHqB+UuJzG5StFl5Ottj1SVOAY=;
	b=wPkQuy2r+IfBeP4LtcQNIPU5grQd3RoOAoKL1WQsmGSghLpYUL6NBHUMbjA2fMoBXYu2R6
	39gbFkqokawAc2Kv81PMrP9vfYjgwxz0j1w9xIuQFBHBp4kjQjDNMsT2NMP79OiS5FzoHC
	nOje9j+cUpOWmbg2n72CM1Wno/mUEV04W8Pf86SNjc7EyuoQiXuOtch4CnQj8pRo1VGRkl
	0yRqTN/lSDGDxJoj+AanbEKu0/WVbQY3CsCUs5dTylKQTKM6JrcjGlTI4ijJLcJiqEWYXt
	KEEVh2jsLFqIdgzx3oV28izFv6ydvWuJUYXLR6EvbB3bXE+hcEAmck35RJej+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765530642;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jlp4bOzSrOeJXsyB8SHqB+UuJzG5StFl5Ottj1SVOAY=;
	b=RqQ6BTJGPU9gMZaxCMBx7IGbMe6ABiBJ7EOZ8WxIuq387ChvyJRQ8AW4ccdhYcno7lvXGr
	G21LN+eduwNlAOBA==
From: "tip-bot2 for Heiko Carstens" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] bug: Let report_but_entry() provide the correct bugaddr
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
Message-ID: <176553064088.498.12359989073282127934.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     6e83b79a2e7374821109705c001aa04c0b36b07f
Gitweb:        https://git.kernel.org/tip/6e83b79a2e7374821109705c001aa04c0b3=
6b07f
Author:        Heiko Carstens <hca@linux.ibm.com>
AuthorDate:    Mon, 08 Dec 2025 21:06:58 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 10:05:55 +01:00

bug: Let report_but_entry() provide the correct bugaddr

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

