Return-Path: <linux-tip-commits+bounces-4239-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3911A646CA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCC13AB4EB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 09:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D019821D3EA;
	Mon, 17 Mar 2025 09:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YGFDvE/o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mmq8naO3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1271DDC12;
	Mon, 17 Mar 2025 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742202917; cv=none; b=ce7W8fNb+dOTSjOVEAY5mQ0W4EfbMw5+eSuG8c38/pUS3lzJoBjSlz0Y6S/lEAf9AnuJJVSJsATvZWFkhRzCdl6+jGUf9Lwu26E2rMWIizUNgynzMjfmIcLGnNxw6lyEUsuEHhXNJSlLJeiYOcZ0Fhagx4g5K2tX38lN0yEEgJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742202917; c=relaxed/simple;
	bh=bmFDsdRxEuEX08hqKICcHO1n/Y/NDq5Gp9bPO4XXCHk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P2MENEP+WQ9BXieHRyyA02DG2ZC916omcFWUOEfCCRStThX4AtYx3wjyuXSHej7ZshEZC3TgSVOsl66SyzVMRgIZ6CfycQP3aR8oqkZ7LgCF4EiN/nSqgo6WPnywQZVnmApKp1ch91xhVT5ysJ59ls/EH4/A74H1plKYNcSAHGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YGFDvE/o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mmq8naO3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 09:15:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742202913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1MzOfa5K9zP0C9x07HnzDike3sOpkmqUmvePVHoEYk=;
	b=YGFDvE/oykKTRE56wmhnq4HDa3glLJsdIRrkk3Z+G/YTj08xXxC+j3g4gYPATN6jubaq/9
	JZV8ddqEqTX1ujAPGBL20Yh6JJc0R5QvK11dtVk+oG2ay2dE+svdj40zQcsaFn7oQeX9k4
	jEu6LvnrkLSnZhksFG2zeVAiuO5va77rOwJaSB/a3fH+GZefwSA2NZ6a+vYwbzmrx1uT54
	D8wGwpxIWeRldsrTyBaD6JPbLz3FHfeaX4PJ8mJjzvrkZRDmfjihuF/cveMv85ZPX6O4cY
	wgiJdNCmxGaxz3It3ejw2j2iVNioEY7X0Ayp8C7TGx+TluWBnmiU6SeGgoallg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742202913;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l1MzOfa5K9zP0C9x07HnzDike3sOpkmqUmvePVHoEYk=;
	b=mmq8naO36qB11qk0IyiNKvu17ik5sld0O9HUcPenXxMYmgofcUuE80iqSx2AnGVz7sSfhs
	7YV+NTlZYYiZksCQ==
From: "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86: Check data address for IBS software filter
Cc: Matteo Rizzo <matteorizzo@google.com>, Namhyung Kim <namhyung@kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250317081058.1794729-1-namhyung@kernel.org>
References: <20250317081058.1794729-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220290574.14745.9132867025462242568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     b0be17d8108bf3448a58be319d085155a128cf3a
Gitweb:        https://git.kernel.org/tip/b0be17d8108bf3448a58be319d085155a128cf3a
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Mon, 17 Mar 2025 01:10:58 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 17 Mar 2025 10:04:31 +01:00

perf/x86: Check data address for IBS software filter

The IBS software filter is filtering kernel samples for regular users in
PMI handler.  It checks the instruction address in the IBS register to
determine if it was in the kernel mode or not.

But it turns out that it's possible to report a kernel data address even
if the instruction address belongs to the user space.  Matteo Rizzo
found that when an instruction raises an exception, IBS can report some
kernel data address like IDT while holding the faulting instruction's
RIP.  To prevent an information leak, it should double check if the data
address in PERF_SAMPLE_DATA is in the kernel space as well.

Suggested-by: Matteo Rizzo <matteorizzo@google.com>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250317081058.1794729-1-namhyung@kernel.org
---
 arch/x86/events/amd/ibs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/events/amd/ibs.c b/arch/x86/events/amd/ibs.c
index e7a8b87..24985c7 100644
--- a/arch/x86/events/amd/ibs.c
+++ b/arch/x86/events/amd/ibs.c
@@ -1147,6 +1147,13 @@ fail:
 	if (perf_ibs == &perf_ibs_op)
 		perf_ibs_parse_ld_st_data(event->attr.sample_type, &ibs_data, &data);
 
+	if ((event->attr.config2 & IBS_SW_FILTER_MASK) &&
+	    (event->attr.sample_type & PERF_SAMPLE_ADDR) &&
+	    event->attr.exclude_kernel && !access_ok(data.addr)) {
+		throttle = perf_event_account_interrupt(event);
+		goto out;
+	}
+
 	/*
 	 * rip recorded by IbsOpRip will not be consistent with rsp and rbp
 	 * recorded as part of interrupt regs. Thus we need to use rip from

