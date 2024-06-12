Return-Path: <linux-tip-commits+bounces-1384-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AB12905CC3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:25:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC1931C22235
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09ACB12BEBE;
	Wed, 12 Jun 2024 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMEVF6+V";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBl6deDQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5867E85C7D;
	Wed, 12 Jun 2024 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223869; cv=none; b=FJhE5rOW0VF/v4KGZcMqBmeJea1W3EC+5p4fz2KtrszEBpRP/PpqM+eZqsKjMupwsAWQBNawb7t4QDsRiLB1TrXVUdjhnqcmoFFGcdGGNKL7+Ss7nVR+tglFbEufyFnbUiot1JMBMWgvKQJaS9Wd55EnlGmNmBDL1m5Ittz91Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223869; c=relaxed/simple;
	bh=/sXGdEcsF4SQhT4U2GC61uZPj3BJ0FKyZhnYYuV9YXI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uRDxMtPgzc8Mn80WoscNYuyoHNte/A1ZMCEucw8ZoS7S9DZGQ5wLX6xHOrvhrcYJ6CPD7AD2JnyUX57HP/q3fKvqFj6aH1G0R6mrRQ3SG5YAyTx83GaScrlEw8WMrkAXOxZbAn36DEIqUZw1zBU24OdF43DdPX7UrU0FP2WOhxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iMEVF6+V; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBl6deDQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRuh8DzgEcKJr7XOwhgYDmRR3aTwwhSnCbWDVRpVGWs=;
	b=iMEVF6+Vr6pjdV0R/LXF18U6elNcqs3SwBxwPXIpFDBQuvbAo/hV9EC98Xei6V7ZkoHerK
	OEf/eLjKJIbMM38os9CyPXJ02bWbIJXsX1I85t2V3BCxbPCmSTWXLjzRHhDPgoYjds4TE8
	QX+8W0XKXk9h9LOLYZmJeYpLJU98T6bKQNmXhTvcwdqalMcc7zFw0/hwT9ql87wVt/mzqD
	reRcpBUIAf+QeD3UKZhqhAE1tdGwMV+KRPGiRPXVDj6VgSw/5GtsqNiKaAvndQhKCwqxxJ
	Vtb633SH4/rujRY4w6AbHD3geLN66tbDyJ5vLa4ITBKD+Mk2KxuE6fu4SLwj1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223865;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bRuh8DzgEcKJr7XOwhgYDmRR3aTwwhSnCbWDVRpVGWs=;
	b=lBl6deDQuUWGy5kKFebYGiP8BYuOlEuEHJoIoQV+njmEj+ncQLDzriZjHHGgDN7BbA7g0Z
	3YjBQAP52E+j4mAQ==
From: "tip-bot2 for Christian Heusel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] tools/x86/kcpuid: Add missing dir via Makefile
Cc: Christian Heusel <christian@heusel.eu>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240531111757.719528-2-christian@heusel.eu>
References: <20240531111757.719528-2-christian@heusel.eu>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386509.10875.5296577084145807557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     1d2a03d26a69e4e781077f5fbb5466143928c737
Gitweb:        https://git.kernel.org/tip/1d2a03d26a69e4e781077f5fbb5466143928c737
Author:        Christian Heusel <christian@heusel.eu>
AuthorDate:    Fri, 31 May 2024 13:17:58 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:33:45 +02:00

tools/x86/kcpuid: Add missing dir via Makefile

So far the Makefile just installed the csv into $(HWDATADIR)/cpuid.csv, which
made it unaware about $DESTDIR. Add $DESTDIR to the install command and while
at it also create the directory, should it not exist already. This eases the
packaging of kcpuid and allows i.e. for the install on Arch to look like this:

  $ make BINDIR=/usr/bin DESTDIR="$pkgdir" -C tools/arch/x86/kcpuid install

Some background on DESTDIR:

DESTDIR is commonly used in packaging for staged installs (regardless of the
used package manager):

  https://www.gnu.org/prep/standards/html_node/DESTDIR.html

So the package is built and installed into a directory which the package
manager later picks up and creates some archive from it.

What is specific to Arch Linux here is only the usage of $pkgdir in the
example, DESTDIR itself is widely used.

  [ bp: Extend the commit message with Christian's info on DESTDIR as a GNU
    coding standards thing. ]

Signed-off-by: Christian Heusel <christian@heusel.eu>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240531111757.719528-2-christian@heusel.eu
---
 tools/arch/x86/kcpuid/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/arch/x86/kcpuid/Makefile b/tools/arch/x86/kcpuid/Makefile
index 87b554f..d0b4b0e 100644
--- a/tools/arch/x86/kcpuid/Makefile
+++ b/tools/arch/x86/kcpuid/Makefile
@@ -19,6 +19,6 @@ clean :
 	@rm -f kcpuid
 
 install : kcpuid
-	install -d  $(DESTDIR)$(BINDIR)
+	install -d  $(DESTDIR)$(BINDIR) $(DESTDIR)$(HWDATADIR)
 	install -m 755 -p kcpuid $(DESTDIR)$(BINDIR)/kcpuid
-	install -m 444 -p cpuid.csv $(HWDATADIR)/cpuid.csv
+	install -m 444 -p cpuid.csv $(DESTDIR)$(HWDATADIR)/cpuid.csv

