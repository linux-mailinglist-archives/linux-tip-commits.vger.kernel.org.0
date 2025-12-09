Return-Path: <linux-tip-commits+bounces-7615-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFDDCAF6CE
	for <lists+linux-tip-commits@lfdr.de>; Tue, 09 Dec 2025 10:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0ED213075669
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Dec 2025 09:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79772DA765;
	Tue,  9 Dec 2025 09:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uoWO5piy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HD6rIS70"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5EE277007;
	Tue,  9 Dec 2025 09:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765271838; cv=none; b=IhA9dntZUfRSvPIGDI44/q6scRCkFrS2gRPyujm5OgFBWJd+tMBrRk7DppZgefAsYel18ivB0mrGojhA2UXbrDAC2CdWspjfk6upnSK/5ywAwCn37qtHXh6V/wYvXHNxZ+TGQ7DN2hbzJsx/1IDrqhCchyB9BX9I2L+0YWbVzmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765271838; c=relaxed/simple;
	bh=nUXlXshUA6noNOmRe7gyrDjgSRLrF3dVYHMXWBsXrX0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ujypqU22HJau4LwyUlw5DC1CdonCVh/VoyMo7/NZkb6LCFKbv5cQ/X760QPMXJIPUL1//lt1iNBnui1/0e8Y3A8ONmoCYBEpiYqz9+rzy4D1SKvqJ3IaVzrjW3Dr61zcP38aGC8YMIS2xYyaccvrcsWHj889rcPclCsp14QrSBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uoWO5piy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HD6rIS70; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Dec 2025 09:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765271829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iri7MyXIC9Z/LMRIdsz2msyUQPovs42Et3/RPGeeHlc=;
	b=uoWO5piyub4Rcv3XP+OeUfc+7cCl5a0OcuF5jcbdbwHcEAuRzKNRTmtVFPzMzqgAZuvIFc
	KGLRQ3flHiaYw6W4Z9F45BbDCyvht+WGsntVGIrWYzB5a5T+w0P6PyGj8ovmDvG0jQOdQr
	pgfKnnNLlIT2qbkBvXHwO8k7KVKjiDVKg2rul1CpapwXQDoYr2vtx0mg3kEK5eMX+xWDiA
	zL7xLbyE+1M0JNCNy94wu5dIwI3SyWjuT8Wyo0r64pjIil8K2zvRxw+uUgygBOUTk6+ZzU
	6WSFl05SGs80h7uVJRS6vCmv07NCDasyieF5UrqtdfHy7SrQESFUGDvAjGzwYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765271829;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iri7MyXIC9Z/LMRIdsz2msyUQPovs42Et3/RPGeeHlc=;
	b=HD6rIS70K+d6tI1f43qcRl4b7fN3oz6ESrFOnZEPb5jph08HlR1sFArUqFcLF9jDkDkvET
	mZXSEFT+cZKIElBQ==
From: "tip-bot2 for Brendan Jackman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/urgent] bug: Hush suggest-attribute=format for __warn_printf()
Cc: Brendan Jackman <jackmanb@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251207-warn-printf-gcc-v1-1-b597d612b94b@google.com>
References: <20251207-warn-printf-gcc-v1-1-b597d612b94b@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176527179323.498.3669459412099769581.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     40f40edaa30137fe7f09752db60a7a6ab4124ef9
Gitweb:        https://git.kernel.org/tip/40f40edaa30137fe7f09752db60a7a6ab41=
24ef9
Author:        Brendan Jackman <jackmanb@google.com>
AuthorDate:    Sun, 07 Dec 2025 03:53:18=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Dec 2025 10:14:47 +01:00

bug: Hush suggest-attribute=3Dformat for __warn_printf()

Recent additions to this function cause GCC 14.3.0 to get excited
(W=3D1) and suggest a missing attribute:

lib/bug.c: In function =C3=A2=3D80=3D98__warn_printf=C3=A2=3D80=3D99:
lib/bug.c:187:25: error: function =C3=A2=C2=80=C2=98__warn_printf=C3=A2=C2=80=
=C2=99 might be a candidate for =C3=A2=C2=80=C2=98gnu_printf=C3=A2=C2=80=C2=
=99 format attribute [-Werror=3Dsuggest-attribute=3Dformat]
  187 |                         vprintk(fmt, *args);
      |                         ^~~~~~~

Disable the diagnostic locally, following the pattern used for stuff
like va_format().

Fixes: 5c47b7f3d1a9 ("bug: Add BUG_FORMAT_ARGS infrastructure")
Signed-off-by: Brendan Jackman <jackmanb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

