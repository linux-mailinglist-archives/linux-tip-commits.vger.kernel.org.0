Return-Path: <linux-tip-commits+bounces-1316-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9738D5ED6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 May 2024 11:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C5231F22215
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 May 2024 09:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66FFE1CD35;
	Fri, 31 May 2024 09:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jXFelcdj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="voUX99ON"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07C013A25F;
	Fri, 31 May 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149046; cv=none; b=hKypf7YtGWFxE1uVYo1g/qyDu4QotJhw7wDVow2VOKbsAIZ9Ir3o5NA4xQaOesYXiGl6aOkgvZFwTSiyBsweOFW26kz8h1jYoTh0xXyYyYhFHv+ow0m5KALIKAoMlfsZSLsPc8CR9epJoK2+M+TVydpPJsKE+bIPV4pTcoCTYwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149046; c=relaxed/simple;
	bh=U/sDEeCKrtZfu+47S+svdDqf22jb/HoBEuGSJIGLODY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cAJ4RUqmN/S8cB6Fc29mvNFDL+ajtAQOnNgRy1qn1EKDcaZQLcNjBhlC721A7hXM353zBhT8YpKaEf1HFcTP2jgm7/nSjeph6YuaKvLwNrJYfo5pNBanqgpLpAL/Oz/ryE2QkjWeWStTrigrYi1N6tfFywk1LwisQrIT9435l3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jXFelcdj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=voUX99ON; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 31 May 2024 09:50:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717149043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9JIuynOn+qXRbDDM55SC1nRXrrXJNSK5uv7OEBjzNU=;
	b=jXFelcdjMXj2l+ie6Lgh0cadRdmMpc05brSmuXZVCSrdSbAed2IlmkOoHPk8zm9y55yvKU
	QYJZLVNf57ut+BiBOZyIdPyAuNrqabm6MazJX4lCqBsKVxwCrvuuj6/ZLbpDouFar8TmJK
	LM4Ycqk33kPN1mP9btL53aRP1ajSr5RmbZmHXY+VoZTABBO2za4OdUOGCCPLnYM30qcWT+
	7cj8Wx+qHhiaK2kwCxQGztwzlyKfXGvjHZ4eEW+1ICmgc3osuiijYmrgCUsr/P6oBXqKTM
	CUbYEmxd7URxGZJt6yQRYakbr5Un4m5qBmH9J/kD/ysd3DW9fR1MUzHVVt2c8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717149043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H9JIuynOn+qXRbDDM55SC1nRXrrXJNSK5uv7OEBjzNU=;
	b=voUX99ONbMXerwxfUQEY0aOJW6CN6P9bo4bUKxnFokJgxKtcuVjm3duk8DJSa00ygC/xSx
	sSxLltzsmA1r+zBA==
From: "tip-bot2 for Jeff Johnson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/rapl: Add missing MODULE_DESCRIPTION() line
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240530-md-arch-x86-events-v1-1-e45ffa8af99f@quicinc.com>
References: <20240530-md-arch-x86-events-v1-1-e45ffa8af99f@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171714904273.10875.13779864316560779465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0a44078f2b72abcdda47581c942bd5d0468ec50b
Gitweb:        https://git.kernel.org/tip/0a44078f2b72abcdda47581c942bd5d0468ec50b
Author:        Jeff Johnson <quic_jjohnson@quicinc.com>
AuthorDate:    Thu, 30 May 2024 13:12:03 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 May 2024 11:41:04 +02:00

perf/x86/rapl: Add missing MODULE_DESCRIPTION() line

Fix the warning from 'make C=1 W=1':

  WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/events/rapl.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lore.kernel.org/r/20240530-md-arch-x86-events-v1-1-e45ffa8af99f@quicinc.com
---
 arch/x86/events/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 46e6735..0c5e7a7 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -64,6 +64,7 @@
 #include "perf_event.h"
 #include "probe.h"
 
+MODULE_DESCRIPTION("Support Intel/AMD RAPL energy consumption counters");
 MODULE_LICENSE("GPL");
 
 /*

