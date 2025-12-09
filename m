Return-Path: <linux-tip-commits+bounces-7616-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A9FDCAF6D4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 09 Dec 2025 10:17:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3B5E3080682
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Dec 2025 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715902DC764;
	Tue,  9 Dec 2025 09:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t31I8HSO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XL7udOVq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68D2D94BD;
	Tue,  9 Dec 2025 09:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271839; cv=none; b=OGW7GD1FGFPaymGtwmPI0MgSFjv5vW2S3Lbn3vRokTttXoYaUi4ilJ/isjlnAOUVTqe9P6rLq5t634N3jpMoVV7pwrW4BBY9nwM+FNeyJteCQg0poONcvSKsZ/rOyOM+KrJ4uyLTR3C8V+/Bp+rVxULd0SV69iPs0nP4nXpU5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271839; c=relaxed/simple;
	bh=xdOFwvaR3o25j4JFZNHy9TaoE00/09kH5jXoIUDs0DQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IFjMO8FmVWUgQZvat7DsPFXoMqZ0B0fkLtTMj29g5kXLTRDbN1m9luGlIqr+KPYf/fdgaxNp0vgbCOvrSmmLRFEkn23C+JA3fG1ZgbfjQLSWIdl/7D5Msrf7UYcIPYwfHklYR7tsh+u1yRB156GSvSnd0bxmiFqis3g0pQDXyuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t31I8HSO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XL7udOVq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Dec 2025 09:17:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765271830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/jrZKhR2Jq56adr38FEyU/oYFueRVAfY+uiLm6u5TM=;
	b=t31I8HSOf1G1J36ZZWn1WLU8HJifwRn0I6HSCyjHFkepnB0sZIFzGZMPLrEgKnOoFltS/r
	Pp40ODT4/RceG8HW95EBVmVz1vcA4cvDBy3HULdMu2yLHXe+MIQ04Urpwez5DePdEPACHi
	x37umgd1NYQCH6h5mDjBbqxpwrw7T1Nz8WB77jp/6EzSQ/xrQ461CFcTU78xjVEhZoQnJ+
	3qpbMUjQJcQYJ0InJz9AGL57J/6P7a6+TT22lH+dS29iDU166pVpQps5UAGWkzpm3dfNwq
	9IEUJcdT0ctLra9u57nEI5VzR5R2iCTpaXBuAXUzh8JyK1xV723FvlcPZS+Dag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765271830;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v/jrZKhR2Jq56adr38FEyU/oYFueRVAfY+uiLm6u5TM=;
	b=XL7udOVqk24LZ0llYVKu33eDndnR/5llU4OgOM8kxKd5JEOMTPNoELxY45gXi0Wk25p5SH
	sDf6e6QwiMA/XWAg==
From: "tip-bot2 for Heiko Carstens" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] bug: Let report_but_entry() provide the correct bugaddr
Cc: Heiko Carstens <hca@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251208200658.3431511-1-hca@linux.ibm.com>
References: <20251208200658.3431511-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176527182912.498.3228329252559034654.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     477fa55e3de7c40ba47f10c837c6a32e300893a1
Gitweb:        https://git.kernel.org/tip/477fa55e3de7c40ba47f10c837c6a32e300=
893a1
Author:        Heiko Carstens <hca@linux.ibm.com>
AuthorDate:    Mon, 08 Dec 2025 21:06:58 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Dec 2025 10:14:46 +01:00

bug: Let report_but_entry() provide the correct bugaddr

report_bug_entry() always provides zero for bugaddr but could easily
extract the correct address from the provided bug_entry. Just do that to
have proper warning messages.

E.g. adding an artificial

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

