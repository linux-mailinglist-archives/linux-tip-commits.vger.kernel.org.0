Return-Path: <linux-tip-commits+bounces-7042-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E6DC1969A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4926407264
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B404732ED2D;
	Wed, 29 Oct 2025 09:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ozC0l9+X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h0IKd57g"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CBEA32C954;
	Wed, 29 Oct 2025 09:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730580; cv=none; b=uCVpr+wIE3xVrvesz2Gw5Unod2G9JQNkodnPj/eNf2cirgDHCumiAY2O8KnR/NhzsOvmci9kxYBbLvGuRQLVfG0HAvIyggnh9nKw4nqCQjxJJ0dlhMDVDEAcCXrhFm3O4SPEK54cRKLpgtXtWrtuMN5LtqI5T8Anq6eKrTuMSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730580; c=relaxed/simple;
	bh=pbKw0ixuAbPWrxHbm44m9uqvgtSVZGNwOK9rBDBRa4k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iGEKfu4l7L/m0i1OdFVK72O2hOeS2ZcBGB9W787yeKnUhEZ6cloPmtv0ge3NRKHzu+UMr0pxtQhchpbYroKk2TFS+GjMvH2v3vgc+2XkcDsVQ4S9LO9OKBqhy7AnzG5B+j+Ic08nUpL4kR+mUFEtud04g5Odlx/Q+i0HUWhddSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ozC0l9+X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h0IKd57g; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7lODwrrtWUEVWpycWDqBnya89UK+1+1xTbOMMcYXSI=;
	b=ozC0l9+X8LQ2kNAN52TLq3ScTs5OtlOa4uFAkXS9evQilX1/dACiblNDYx14k9MSP52UvN
	h+On5Fga3lO3FDwlzEG0PnNql5o7/jDpkYikjBc5VlsyqlsTRH0tLdeKitVJsD+Z0C7wfO
	npu9IOiY2qwQtbsuz4P3jx99/zlTWLrPGYrDaaSmYAHDuiAQSCN+EF0Zb1Vm/A3jCNOlx1
	5EXHpXzoWXleX1TPsKZGG4WpHgOn7hDbr0YgwIOyVisNiW87UfCmdO9fZLUVWoXqW89ipz
	guReb4Cx6IzyGgDt76krPtCiyclSUrh1fytmYAg9QitzsHK+gMedu9bTH2SNPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F7lODwrrtWUEVWpycWDqBnya89UK+1+1xTbOMMcYXSI=;
	b=h0IKd57glLt/yc7sFvEzBec07XpZzwphEyeoeJHZ+ayvhhY9gccPWzWo0wM2qZ8ErWkWqk
	MDKeda8kLkqYKrDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] unwind: Clarify calling context
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Steven Rostedt (Google)" <rostedt@goodmis.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250924080119.122507632@infradead.org>
References: <20250924080119.122507632@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173057579.2601451.4074565811440817092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1e74829f36b5db19afc3d17f0a3750e9573710ae
Gitweb:        https://git.kernel.org/tip/1e74829f36b5db19afc3d17f0a3750e9573=
710ae
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Sep 2025 15:49:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:56 +01:00

unwind: Clarify calling context

The get_cookie() function hard relies on IRQs being disabled, but this
isn't immediately obvious when reading the function.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Link: https://patch.msgid.link/20250924080119.122507632@infradead.org
---
 kernel/unwind/deferred.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/unwind/deferred.c b/kernel/unwind/deferred.c
index d2cd3a7..6395192 100644
--- a/kernel/unwind/deferred.c
+++ b/kernel/unwind/deferred.c
@@ -79,6 +79,8 @@ static u64 get_cookie(struct unwind_task_info *info)
 {
 	u32 cnt =3D 1;
=20
+	lockdep_assert_irqs_disabled();
+
 	if (info->id.cpu)
 		return info->id.id;
=20

