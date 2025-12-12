Return-Path: <linux-tip-commits+bounces-7635-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DCFCB866A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 029ED3064BFB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E6131196D;
	Fri, 12 Dec 2025 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r8UsUxHg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AXDCp6c1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27B5248896;
	Fri, 12 Dec 2025 09:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530644; cv=none; b=f89jEavpXFn9DnS7bMgVJsw1vvOzh0cO+QXs9dsaYrJ3ta+JOX1UxSt4Lulib9HIigxCwhL2VWUx5u0sYvpXRBj/yUaJ1l7XIs5KjsPUcVklPiDAidpf8HUXo7sggMWBa1ytiwb6Vh3d3rFjtnDsThQDeYIbryjKXfOlxLMnc1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530644; c=relaxed/simple;
	bh=oA7qyEWgsdIyHeOtcqz5ipMatMvJ1sY3EQSiYZALmYc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C7/qx55zA3l3/ZSDJvT4QD1WtFGN/GmquwlNxWJ+ZAPP+N7YLFTBVit9XOX4ttO17ybbVkBKRRZZBCxmF0/Wb+wkylWvgh8GfkY2VjaY96NGJB6Xs4Ui1BCJn252IkZunHsXhK3RHeIkAPw2AsQQwOTOL2/cGKgV0MoE71wnBGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r8UsUxHg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AXDCp6c1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:10:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765530641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Fl7K4Rt6fjBFzi1GA/F6yyUvCWn4WVglSYjJBkzz08=;
	b=r8UsUxHgbUhDPNE4+Vy/Xl5JUUGwJJHMEqTka+wC5VwImnyCJ/iUQh3YE9sY1vmtC1lS2M
	WI0NzCP2lVVILl2dn8i8ZHrsFBGm4qR2hO1JGskU/M6AfFCt8E5kkIk42XVKUw1l51/Qq4
	hJMoR7lhJ0dLy830YHuLH0oL1kG2JOY0s1P2fJyUjz1PNGA0NKWAREri5pw9yfc9VbKWdN
	ssO87xg+SuftdFbo3IDDtgrn0glhqmnIPZhcuJMDlEBoJ3x5EYxjILeJ+yEf3hvUmWUc25
	YTbWr+kl2aSXI8OwL1xfgyhNtl1fn8EpAqI05r1d+ChY8/sAQ7RYX9nZ6CD15Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765530641;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4Fl7K4Rt6fjBFzi1GA/F6yyUvCWn4WVglSYjJBkzz08=;
	b=AXDCp6c1DpYHHK7J+G/cXyKP+yvpv44RWo3fgaFQ2IIzSK8zoF03MMj8YOGiP5ULS5bX4T
	hFWZlBJel7DbRBDQ==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] bug: Hush suggest-attribute=format for __warn_printf()
Cc: Brendan Jackman <jackmanb@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251207-warn-printf-gcc-v1-1-b597d612b94b@google.com>
References: <20251207-warn-printf-gcc-v1-1-b597d612b94b@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176553063981.498.7621766354621505897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     41a1dcfb7ade1051bdc6e4923099699f45fcbb10
Gitweb:        https://git.kernel.org/tip/41a1dcfb7ade1051bdc6e4923099699f45f=
cbb10
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Sun, 07 Dec 2025 03:53:18=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 10:06:02 +01:00

bug: Hush suggest-attribute=3Dformat for __warn_printf()

Recent additions to this function cause GCC 14.3.0 to get excited
(W=3D1) and suggest a missing attribute:

	lib/bug.c: In function '__warn_printf':
	lib/bug.c:187:25: error: function '__warn_printf' be a candidate for 'gnu_pr=
intf' format attribute [-Werror=3Dsuggest-attribute=3Dformat]
	  187 |                         vprintk(fmt, *args);
	      |                         ^~~~~~~

Disable the diagnostic locally, following the pattern used for stuff
like va_format().

Fixes: 5c47b7f3d1a9 ("bug: Add BUG_FORMAT_ARGS infrastructure")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251207-warn-printf-gcc-v1-1-b597d612b94b@goo=
gle.com
---
 lib/bug.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/lib/bug.c b/lib/bug.c
index c6f691f..623c467 100644
--- a/lib/bug.c
+++ b/lib/bug.c
@@ -173,6 +173,9 @@ struct bug_entry *find_bug(unsigned long bugaddr)
 	return module_find_bug(bugaddr);
 }
=20
+__diag_push();
+__diag_ignore(GCC, all, "-Wsuggest-attribute=3Dformat",
+	      "Not a valid __printf() conversion candidate.");
 static void __warn_printf(const char *fmt, struct pt_regs *regs)
 {
 	if (!fmt)
@@ -192,6 +195,7 @@ static void __warn_printf(const char *fmt, struct pt_regs=
 *regs)
=20
 	printk("%s", fmt);
 }
+__diag_pop();
=20
 static enum bug_trap_type __report_bug(struct bug_entry *bug, unsigned long =
bugaddr, struct pt_regs *regs)
 {

