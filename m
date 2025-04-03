Return-Path: <linux-tip-commits+bounces-4632-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F365CA7A1D1
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 13:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCEDA175CF0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Apr 2025 11:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71A2124BD0C;
	Thu,  3 Apr 2025 11:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NRCV+KFC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ud5UIVoS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9A241689;
	Thu,  3 Apr 2025 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743679601; cv=none; b=EEwm2+7J9HDF5GmPABsNDugidoAUYQq2bzXQlR8PLEiNvM//lwPlsvcRq/y9ZCTghtszfmVu0XAXiF9nL87+47L+Xya3m2WufZRjZYEOMgY9/eDw+jleD45iH3xsn/IluaCv/ppR+P8I4GOFBRkkTy3KN6uFkmu/r1yjc4QjG34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743679601; c=relaxed/simple;
	bh=py3nLhdFHiR2RpAbxp2MXp9645eCXHkUP2hAX8FCRfY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QdQET2J0lIYEeZPfbgcZwcDj+kKLHRQuwe4Mhk6AtEutk4VomcfUOwwsx2RMDCboGsy8fmgQbGEFh2VC39wVcrEvufvo3+vhn/fFhx+JJs5MafUfDyuLUJSWchhDPrk3/3vwtzZpB9xy5EvhbhS1xHKls4gKWRxrNEKn8vTN6Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NRCV+KFC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ud5UIVoS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Apr 2025 11:26:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743679597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izwf/Ch3/XGjmDU5wLQCik3BMfVWbKpRKDMdb2fBh5M=;
	b=NRCV+KFCcRGlWqyNa3TIxsL5p5zcT4XoHaHxkxJLnVVnrylzs2OFDHEdp3qwBGakMIPT0J
	xd2ztIK7PfbIU/fSTTdoGPHz3SXvVxF7qzx/BNT8hLuWt+GnZjDxQ/3NwpF2JRvcCxuob5
	tBBckuZ7an9q+Ah+YsZjO7stuzESAJCJHYjt2mXv5QIHEGjdNcJr197Zmst1ZzSKpaeH06
	xn3njSLc79vKQTNXm2o3jpaeQVUmftb128wuePunGl8n/tJVuJJixfEjUavHMp6NoPgfYZ
	A69z/GWFHSJpqFaRhYmu4uxSxQi5jGPtH+ezoLy/RU7URcelKTbNzgC/25AeBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743679597;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=izwf/Ch3/XGjmDU5wLQCik3BMfVWbKpRKDMdb2fBh5M=;
	b=Ud5UIVoSBA0MLw5+aexEiRrFqNCr9UeBnAKnJLzTdpU0sGKu5KUC7ZMkwYoFWRCmTMosQX
	Um7V6bgSBbLBmhAg==
From: "tip-bot2 for Oleg Nesterov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/isolation: Make CONFIG_CPU_ISOLATION depend
 on CONFIG_SMP
Cc: kernel test robot <lkp@intel.com>, Oleg Nesterov <oleg@redhat.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250330134955.GA7910@redhat.com>
References: <20250330134955.GA7910@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174367959697.14745.16991363734966983099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     975776841e689dd8ba36df9fa72ac3eca3c2957a
Gitweb:        https://git.kernel.org/tip/975776841e689dd8ba36df9fa72ac3eca3c2957a
Author:        Oleg Nesterov <oleg@redhat.com>
AuthorDate:    Sun, 30 Mar 2025 15:49:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 03 Apr 2025 13:08:04 +02:00

sched/isolation: Make CONFIG_CPU_ISOLATION depend on CONFIG_SMP

kernel/sched/isolation.c obviously makes no sense without CONFIG_SMP, but
the Kconfig entry we have right now:

	config CPU_ISOLATION
		bool "CPU isolation"
		depends on SMP || COMPILE_TEST

allows the creation of pointless .config's which cause
build failures.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250330134955.GA7910@redhat.com

Closes: https://lore.kernel.org/oe-kbuild-all/202503260646.lrUqD3j5-lkp@intel.com/
---
 init/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/init/Kconfig b/init/Kconfig
index 681f38e..ab9b0c2 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -709,7 +709,7 @@ endmenu # "CPU/Task time and stats accounting"
 
 config CPU_ISOLATION
 	bool "CPU isolation"
-	depends on SMP || COMPILE_TEST
+	depends on SMP
 	default y
 	help
 	  Make sure that CPUs running critical tasks are not disturbed by

