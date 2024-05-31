Return-Path: <linux-tip-commits+bounces-1317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE4D8D5ED8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 May 2024 11:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBBA3284780
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 May 2024 09:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D7E13F44F;
	Fri, 31 May 2024 09:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKhGIZkA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b0PIRp+y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E078E13774B;
	Fri, 31 May 2024 09:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149047; cv=none; b=JLBzctmL3qLuYnWibeTcqSd54oYOPr7ddjTu4PU8R46UbTqCnKcHo7aXa3cPVf5p5SCJCa6m5R4+uG5NFLDD0aZJNjo5VvcdQYpq0UFI8mMpZGi7Gy0noUi8TiEoDzNMJRJJarn+JB5RR2cntd0NoDjc/+5dpVqCfFFP13aUr4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149047; c=relaxed/simple;
	bh=w7IMHtws+30In+oO8BQCnbuRK3FuJZUbjVB3lg6RPnQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SGGDx2DwyM8uMl3ouCgH1ZAv297UqMghMKrPJjmZyxoI1c+K3ss8keT1WqtskLiA+CkGqUfMES5nVV1Flu3ph5N0hySyaKNKf9aHGwfu89780/TO52w1AFA4hs6p367eozULV/saeWcqJo8RoVFtRg5HCqXLZft81W3NC0zCGX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKhGIZkA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b0PIRp+y; arc=none smtp.client-ip=193.142.43.55
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
	bh=RaJNhvi+sciJc8wWv7Is7D/W4AZtfISJw34fjJewx4c=;
	b=hKhGIZkAZJqQFaJW9vCWmQf8Xh//Ee/VERn/q32Ps68WdcVK8CxIL6hv2iuA5hjBceS0lp
	CGp+5xgHAmSjTejrURsj8abxZwjpxeXmW+L4EEMPixxQG2MvXvyoWZg0IQpkLpEL4w91ox
	6+861998DXdP5t8lalkZcTuVD9aaCRpei7lNd+ZIWHgzpsKSfiToe9+BkSjvqcKVzpQsgy
	DHtiLguqxpaxG8SvQjcaXbhcvOO1yC5YZJzzK7qv8ssPOVci6/LnNt2N3ok3M/+2U+WTbD
	194DefDbfd4vQYcVsHOA+2AaRWcn2kCg0surfzf9RLh6zzsfLM9ConaaNbRCLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717149043;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RaJNhvi+sciJc8wWv7Is7D/W4AZtfISJw34fjJewx4c=;
	b=b0PIRp+yFAm0UzvEgkUNeLQPb/bweVxl/wuO9950+2CosEmgSnzB5FGJ9XdC1qT3Gs72mw
	rImLsB0BZc97cbDA==
From: "tip-bot2 for Jeff Johnson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/urgent] perf/x86/intel: Add missing MODULE_DESCRIPTION() lines
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240530-md-arch-x86-events-intel-v1-1-8252194ed20a@quicinc.com>
References: <20240530-md-arch-x86-events-intel-v1-1-8252194ed20a@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171714904251.10875.1333569603667497289.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     dc8e5dfb52d56e955ad09174330252710845b8d2
Gitweb:        https://git.kernel.org/tip/dc8e5dfb52d56e955ad09174330252710845b8d2
Author:        Jeff Johnson <quic_jjohnson@quicinc.com>
AuthorDate:    Thu, 30 May 2024 13:42:51 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 31 May 2024 11:41:15 +02:00

perf/x86/intel: Add missing MODULE_DESCRIPTION() lines

Fix the 'make W=1 C=1' warnings:

  WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/events/intel/intel-uncore.o
  WARNING: modpost: missing MODULE_DESCRIPTION() in arch/x86/events/intel/intel-cstate.o

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Link: https://lore.kernel.org/r/20240530-md-arch-x86-events-intel-v1-1-8252194ed20a@quicinc.com
---
 arch/x86/events/intel/cstate.c | 1 +
 arch/x86/events/intel/uncore.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index e64eaa8..9d6e8f1 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -114,6 +114,7 @@
 #include "../perf_event.h"
 #include "../probe.h"
 
+MODULE_DESCRIPTION("Support for Intel cstate performance events");
 MODULE_LICENSE("GPL");
 
 #define DEFINE_CSTATE_FORMAT_ATTR(_var, _name, _format)		\
diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 419c517..c68f5b3 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -34,6 +34,7 @@ static struct event_constraint uncore_constraint_fixed =
 struct event_constraint uncore_constraint_empty =
 	EVENT_CONSTRAINT(0, 0, 0);
 
+MODULE_DESCRIPTION("Support for Intel uncore performance events");
 MODULE_LICENSE("GPL");
 
 int uncore_pcibus_to_dieid(struct pci_bus *bus)

