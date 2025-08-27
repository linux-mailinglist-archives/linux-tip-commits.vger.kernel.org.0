Return-Path: <linux-tip-commits+bounces-6377-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20C76B37AA3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 08:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD2943B72D2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Aug 2025 06:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 373452F49F3;
	Wed, 27 Aug 2025 06:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0e2huWx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cz1fwAVL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDCA2C0272;
	Wed, 27 Aug 2025 06:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756277125; cv=none; b=TcRz1Bxydn+cqc72v42wr/sMsE5Mtx6bpNC4FKA7/hsn8+X9LNQ4mE4aXw3Z2H6OJ1NeJEt1BwYYufpAMck+Mf+g962CX9mRfV/uWniuz7VeNp+uLxG8IG40dORyhxGGW1mRdOZbZr2ARReWS1p0v3ZYefqoCT3Mkzz2jboOQuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756277125; c=relaxed/simple;
	bh=EqeCcCwX5nqul7P1Q38YGdZ3Yzbh6I9p12Bz1xn7RQU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CR7Qrv1XT0AvM/Ln82z2yipbIlHyb2HdZe1QQ9F6KPSHLyjGZnKS9o/o0aLu8MSL8+umQclJWiNWUy/Rtk5n6n/Pg+Zjqn0SlYkotHm2JeQRWePh1dQkn5s53Qahb4Hrw4YcN2UaZ+CJscA4v7LaGLWHFJ6xerbhIugtjZRoc9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0e2huWx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cz1fwAVL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 06:45:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756277122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4RP5C2zXVRc8hpDXBWFxVBmI3JnQ44PEExj/NMS7oo=;
	b=E0e2huWx817stKDZI0JJ5fiwCvZ0Iwx5Eses2dbAjOOJCUgYn4OVEQXKLAe6fsX6kLHkVO
	b9hkzylAQHqDy7r9YjUifqzYA557U4DsVaFC58Jn6jG3xJvWbBkd6bz/guwWnhaNNBWQzf
	8lr1Nmz2OOGZGqksoe0jB5ps0KlkwoEKMh7ND98I6sJNwEE//bB/6MY8G7cMF0Sng6dgI9
	8/zUrsVKoFyGJNEMrEtziAl1XlD+TWtQNsu9U0CLXSmJg4G7xIkV/Pp4BGSeWZs8qPCOHV
	XfTKksxjCspuvWH63pfGcWVGimX6lxZ9SjNlTTMZDFEe1s1zIrMU9vc7lIt/Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756277122;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s4RP5C2zXVRc8hpDXBWFxVBmI3JnQ44PEExj/NMS7oo=;
	b=Cz1fwAVLR1b9SPaAPSGy4owzj1z8hwalzGBTJR2CDR358tM/VfSsh39CqS1VeFEz2CpCao
	LAcdiD7S9dBDS5CQ==
From: "tip-bot2 for Steven Rostedt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER
 instead of current->mm == NULL
Cc: "Steven Rostedt (Google)" <rostedt@goodmis.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250820180428.592367294@kernel.org>
References: <20250820180428.592367294@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175627712063.1920.17265851610092530439.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     90942f9fac05702065ff82ed0bade0d08168d4ea
Gitweb:        https://git.kernel.org/tip/90942f9fac05702065ff82ed0bade0d0816=
8d4ea
Author:        Steven Rostedt <rostedt@goodmis.org>
AuthorDate:    Wed, 20 Aug 2025 14:03:41 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 26 Aug 2025 09:51:13 +02:00

perf: Use current->flags & PF_KTHREAD|PF_USER_WORKER instead of current->mm =
=3D=3D NULL

To determine if a task is a kernel thread or not, it is more reliable to
use (current->flags & (PF_KTHREAD|PF_USER_WORKERi)) than to rely on
current->mm being NULL.  That is because some kernel tasks (io_uring
helpers) may have a mm field.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250820180428.592367294@kernel.org
---
 kernel/events/callchain.c | 6 +++---
 kernel/events/core.c      | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/events/callchain.c b/kernel/events/callchain.c
index cd0e3fc..5982d18 100644
--- a/kernel/events/callchain.c
+++ b/kernel/events/callchain.c
@@ -246,10 +246,10 @@ get_perf_callchain(struct pt_regs *regs, bool kernel, b=
ool user,
=20
 	if (user && !crosstask) {
 		if (!user_mode(regs)) {
-			if  (current->mm)
-				regs =3D task_pt_regs(current);
-			else
+			if (current->flags & (PF_KTHREAD | PF_USER_WORKER))
 				regs =3D NULL;
+			else
+				regs =3D task_pt_regs(current);
 		}
=20
 		if (regs) {
diff --git a/kernel/events/core.c b/kernel/events/core.c
index bade8e0..f880cec 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -7446,7 +7446,7 @@ static void perf_sample_regs_user(struct perf_regs *reg=
s_user,
 	if (user_mode(regs)) {
 		regs_user->abi =3D perf_reg_abi(current);
 		regs_user->regs =3D regs;
-	} else if (!(current->flags & PF_KTHREAD)) {
+	} else if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi =3D PERF_SAMPLE_REGS_ABI_NONE;
@@ -8086,7 +8086,7 @@ static u64 perf_virt_to_phys(u64 virt)
 		 * Try IRQ-safe get_user_page_fast_only first.
 		 * If failed, leave phys_addr as 0.
 		 */
-		if (current->mm !=3D NULL) {
+		if (!(current->flags & (PF_KTHREAD | PF_USER_WORKER))) {
 			struct page *p;
=20
 			pagefault_disable();

