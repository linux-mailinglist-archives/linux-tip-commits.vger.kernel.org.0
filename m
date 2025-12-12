Return-Path: <linux-tip-commits+bounces-7638-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AECCB8740
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:27:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D4DBC303E035
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086F53126A6;
	Fri, 12 Dec 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T6JORfFp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RffRQzmH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F06311588;
	Fri, 12 Dec 2025 09:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531410; cv=none; b=twiR5iLw7dHrDQJFE9E3CumMUjg9lrpbf2gSCWFDuGGfSW4IDHKfYcZCuqr/FN+4EDvNleWI9jRGMeWCPwBsWXdgT7IiSmOCK3+JhW2W4GvQGXo0xbWETQoSf5uBZEWvZ+Dy5qG+4ZywBrAZ6UIdMV7lcL63oL1ShdmHdyZBiWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531410; c=relaxed/simple;
	bh=s1tUMOWUcaYa0x+2YPEgbiCup4EStr9hMHJgovHfoZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u+YZ0nGRcTQywn4GFDw84tTs2FxrQ40rpobvUiPo7ScimIXBXqxh4h+ibr8VqI83fP2vhPWBxHYxEs3z5zuZhuMUpg+Zrb3kXi7x+vr3au2+nDtHsEAIjbtSHoxVjM1W6+Luyf9Y+TF0C53Z0VaRICwpDqP8hRbNPZzg9cBiFSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T6JORfFp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RffRQzmH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765531404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVaIV10w9ZXqU1C/Lq1c9586TkoGmtvaOq4yDYjzFMI=;
	b=T6JORfFpbJmxEKDfJw92R2C+oYAQ6xtXs0jME4m5raB+8/g+T/GDjDaVhnBf+ZU0zLdQLq
	CI4Pj3GBF+DccqmEMyw23lZjiUprYlUefFEciTVBNKSOpRnUXD9xDEb4j/MOhU87P11rVu
	BMHH3ZX+Dr+za6EXh4MHR5AFmguJ1/NPNk2gqthjQki33YdC1iBdxukgy0MBPg9wWlSZgB
	9MXkKlSKLfQe/rDBPobhD22SeTpKBor7ycbAR/5ZMEpkZHMgPu2B5Tq8ybBMRmXANtH0uj
	5U2x2hrTRzZIz1stcw8xX0S0a2oH+yKxqWvMWTz7O5QyEFYMjnXBptbKmRZR/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765531404;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVaIV10w9ZXqU1C/Lq1c9586TkoGmtvaOq4yDYjzFMI=;
	b=RffRQzmHDCB4Z96j746lJEVmLwBDTWVXCK8/Ahtb4dsj9XCy+qxNOc1I8fBjBlsFQl5OAI
	fFS5SuVM5BOEEcDQ==
From: "tip-bot2 for Tal Zussman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/mm/tlb/trace: Export the TLB_REMOTE_WRONG_CPU
 enum in <trace/events/tlb.h>
Cc: Tal Zussman <tz2294@columbia.edu>, Ingo Molnar <mingo@kernel.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 David Hildenbrand <david@redhat.com>, Rik van Riel <riel@surriel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251212-tlb-trace-fix-v2-1-d322e0ad9b69@columbia.edu>
References: <20251212-tlb-trace-fix-v2-1-d322e0ad9b69@columbia.edu>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176553140319.498.9441845818483192284.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     2d130eeeaff6c7129b443d12009f405cc98de86e
Gitweb:        https://git.kernel.org/tip/2d130eeeaff6c7129b443d12009f405cc98=
de86e
Author:        Tal Zussman <tz2294@columbia.edu>
AuthorDate:    Fri, 12 Dec 2025 04:08:07 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 10:18:14 +01:00

x86/mm/tlb/trace: Export the TLB_REMOTE_WRONG_CPU enum in <trace/events/tlb.h>

When the TLB_REMOTE_WRONG_CPU enum was introduced for the tlb_flush
tracepoint, the enum was not exported to user-space. Add it to the
appropriate macro definition to enable parsing by userspace tools, as
per:

  Link: https://lore.kernel.org/all/20150403013802.220157513@goodmis.org

[ mingo: Capitalize IPI, etc. ]

Fixes: 2815a56e4b72 ("x86/mm/tlb: Add tracepoint for TLB flush IPI to stale C=
PU")
Signed-off-by: Tal Zussman <tz2294@columbia.edu>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Rik van Riel <riel@surriel.com>
Link: https://patch.msgid.link/20251212-tlb-trace-fix-v2-1-d322e0ad9b69@colum=
bia.edu
---
 include/trace/events/tlb.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/tlb.h b/include/trace/events/tlb.h
index b4d8e7d..fb83695 100644
--- a/include/trace/events/tlb.h
+++ b/include/trace/events/tlb.h
@@ -12,8 +12,9 @@
 	EM(  TLB_FLUSH_ON_TASK_SWITCH,	"flush on task switch" )	\
 	EM(  TLB_REMOTE_SHOOTDOWN,	"remote shootdown" )		\
 	EM(  TLB_LOCAL_SHOOTDOWN,	"local shootdown" )		\
-	EM(  TLB_LOCAL_MM_SHOOTDOWN,	"local mm shootdown" )		\
-	EMe( TLB_REMOTE_SEND_IPI,	"remote ipi send" )
+	EM(  TLB_LOCAL_MM_SHOOTDOWN,	"local MM shootdown" )		\
+	EM(  TLB_REMOTE_SEND_IPI,	"remote IPI send" )		\
+	EMe( TLB_REMOTE_WRONG_CPU,	"remote wrong CPU" )
=20
 /*
  * First define the enums in TLB_FLUSH_REASON to be exported to userspace

