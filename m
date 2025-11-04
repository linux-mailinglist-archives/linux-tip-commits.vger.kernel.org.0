Return-Path: <linux-tip-commits+bounces-7248-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E81C2FD64
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:24:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECD2918888D4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CB97320CC3;
	Tue,  4 Nov 2025 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ProrDHzb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DzkRpmSO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24D31E102;
	Tue,  4 Nov 2025 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244263; cv=none; b=Pz0MFHVPich08eQUHe4PNU4iQeQY+8H+1kedeFDfkAhZug71LcXqKldhPi0rV8q/14s6Odn7t4CM/z3Xcdh7CU4RCkLEdF90BXa7O6f1ZS4KoQu7mUEoUSbk7SBPN33MBIyGTKd0EIDGbp+ykhsympFMdQgXTUbTOEH5Z/xmZSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244263; c=relaxed/simple;
	bh=snvxwxZ2Z6WOOwjfWyAx76X6+Hzle9Kg6w6J9UaFdYk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CgF8ZSPAANWuL+yUdXHWXaqG5uNimMN+yG9sB06jx0pIFGIXlTMAPNROGKPWO3s9xDW9KaCQCmGRNyaGwi7rp39fOI+ZVrBpdgLZ8s3VNfSahQ0gxqxeyBRceHoG0qLCRUbefPRut7FJUyAnTO4hbdNCjNL3urs5yQo+0EArQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ProrDHzb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DzkRpmSO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKvfJbzEAfhsdi3HPRkVfSJB5hu0oh0G7vmOIME3Z7g=;
	b=ProrDHzbCypQnJFVGaQlxQmyk+hfTu1lp4X9sjKy/wOBppK+kKDnYlLY5IvTiBoeMZt8zy
	4CeNS7uzlj7fjYlV8EpPNejiF458WgNdx913dVlR/G6sQTKp0hPcPVCn00TOAjQpEcdz9X
	oYsqZyXx0jMIoPc+ptOXv1NriGGTN26deknEzDLEv7y/qsCWocXpFWl9R1sX+IA5uWD61N
	/zM43x80cNF4aBF1SVNmcnPofcaMzyzwtl41J5QDgOcuzeVQyAZXS//VNNX59FLB1S7OIi
	G+ESafmEa/S9f+C+GcDqMxuEHAlgGe9wsPjdcjAydfRUGDieVEzj8lWc4XTK+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YKvfJbzEAfhsdi3HPRkVfSJB5hu0oh0G7vmOIME3Z7g=;
	b=DzkRpmSOtVWPr2VjHC40vJqPPVoonQvpWUfbcC1bL+NEn9VvSOOClr8Sm5YYk3575DQA/7
	F4Iaut5iBY8tKODw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Simplify registration
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.274661227@linutronix.de>
References: <20251027084306.274661227@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224425825.2601451.15206634611280288656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     067b3b41b4dd5bf51d6874206f5c1f72e0684eeb
Gitweb:        https://git.kernel.org/tip/067b3b41b4dd5bf51d6874206f5c1f72e06=
84eeb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:24 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:30:05 +01:00

rseq: Simplify registration

There is no point to read the critical section element in the newly
registered user space RSEQ struct first in order to clear it.

Just clear it and be done with it.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.274661227@linutronix.de
---
 kernel/rseq.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 51fafc4..80af48a 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -492,11 +492,9 @@ void rseq_syscall(struct pt_regs *regs)
 /*
  * sys_rseq - setup restartable sequences for caller thread.
  */
-SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
-		int, flags, u32, sig)
+SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len, int, flags,=
 u32, sig)
 {
 	int ret;
-	u64 rseq_cs;
=20
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -557,11 +555,9 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, r=
seq_len,
 	 * avoid a potential segfault on return to user-space. The proper thing
 	 * to do would have been to fail the registration but this would break
 	 * older libcs that reuse the rseq area for new threads without
-	 * clearing the fields.
+	 * clearing the fields. Don't bother reading it, just reset it.
 	 */
-	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
-	        return -EFAULT;
-	if (rseq_cs && clear_rseq_cs(rseq))
+	if (put_user(0UL, &rseq->rseq_cs))
 		return -EFAULT;
=20
 #ifdef CONFIG_DEBUG_RSEQ

