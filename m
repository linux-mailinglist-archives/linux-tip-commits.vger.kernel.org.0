Return-Path: <linux-tip-commits+bounces-7645-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CAFFECBA7FA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B6B3011AA7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Dec 2025 10:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3F2F5339;
	Sat, 13 Dec 2025 10:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Nbrbp8+l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lKnjoSmo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AA72F49FE;
	Sat, 13 Dec 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765620442; cv=none; b=rG7iWTMV2Z38IAQifpMhQ2G+ce530FpFKQQoeFmc0j2HRS9YVjEW36dZ3oAxrzMMotW3ffuz2UJIXz1NfJOrgLYoEd5jrV+ro1LWydhrR5UEdkDnXutVvL94W6uaemWB6cRfWdfSNPYKlun3T7Eh8NT6LFs+Onm8N/ImIcZGYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765620442; c=relaxed/simple;
	bh=fXZuvcRviY+OgnS5fUNwzjZMPRN9FviV55NBsehRlas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eoA4F3swDqXssrIvlAoxjEOGRHSxzH7mfAsRQfhrNMkx7UYE8AJ15wGrcfnUqDsOjeaUw8AlAwkOrrALMWBaBj5jvHrs+9WmOmU6CdGw5vbojA1Ta1m9vde1EWin41n8g+6QHKAdZVUrgqxLk/IUfeHKoc+iiu9glwxB6S0Mpnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Nbrbp8+l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lKnjoSmo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Dec 2025 10:07:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765620437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UZ8Kawd0H1LwPJsXzrJUfsW/5/G59bpLhqKiXVENe8=;
	b=Nbrbp8+lXJQKWPEeti9T6glGVAT56MliOiQwSxJeWRSHnO553VPhic+9OS3i+wBTkZm381
	DMYaa2mb0VHMmuHgyyywtBz4FXkrN3L+BTXghhmORrDptGOYFQlhri6NShLk+Tw080F8n/
	UC8+h99nrDke9DXZw1cISyv861KffKpWcCm6pRdTQvVgcqMELe5KnKBMc1qz4vXPZpEiWk
	plT1ZYRlcDDxfhMJe91R2mLkNC+fAI5hPcxIRctI5sQ7X2TN6S58+dSJUF0571j3mSQybJ
	2bW4uWqTR4oii2TTZaYpZ3OLO6HzRpO4Yoak9i6qPtRBcKXuPeCopE9RG1L+yQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765620437;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UZ8Kawd0H1LwPJsXzrJUfsW/5/G59bpLhqKiXVENe8=;
	b=lKnjoSmouQxXD8HCsfHVY7WQOltoCkjDdnWD+hnFC3mL959d19Idg0/tcRK8X4hzoFIgfL
	8jPLx0F9ULhT4RDw==
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
Message-ID: <176562043619.498.7745633750615805482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     8b62e64e6d30fa047b3aefb1a36e1f80c8acb3d2
Gitweb:        https://git.kernel.org/tip/8b62e64e6d30fa047b3aefb1a36e1f80c8a=
cb3d2
Author:        Tal Zussman <tz2294@columbia.edu>
AuthorDate:    Fri, 12 Dec 2025 04:08:07 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 13 Dec 2025 11:01:16 +01:00

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

