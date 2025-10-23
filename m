Return-Path: <linux-tip-commits+bounces-6986-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 66998BFFC1F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Oct 2025 10:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FC873A49A7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Oct 2025 08:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47982E6CCD;
	Thu, 23 Oct 2025 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QXJOoCbn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="30++XHrh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E762C257827;
	Thu, 23 Oct 2025 08:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761206461; cv=none; b=LF0Mo6JAdzEp4jPVJyP1J3ABKFSChjk0G3gDijLq0rodurTYEpxxAXpEqMIG/1c4GYhomN1Tx+USvZ2KbZ6OwyRP7TJUHqbc2r0R16KMbiuO1eVxhyu0yQ706XFCAS8oLQ+Ri37YZDPYfPl8g7t0QHIr+VHmd2+CYd+Gz6bBgts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761206461; c=relaxed/simple;
	bh=xVl+OOG4pdgCh6L81H5p5tPKjQ1PAaXWAg20Ct+OGU0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jC9AnP5Kd2Mv4IZbLgpu4R6YDK+tOKzdsErPb8qgjSVnk/ACE+9Msru+hpODF/INBwLmwC7t15vCnxmIvIru0CjpZCiUKsPRh3n4JhCvcUGLbF+09zpUmtfpeSe7vNtmVfp//t7KXJEvTwgJhgu03ftYTLqAY+PvaEkNfZ9sv5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QXJOoCbn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=30++XHrh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Oct 2025 08:00:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761206455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00Z8zJXcen6vBAxIwzWzqcCaxkxXun5gYD/COcx+fks=;
	b=QXJOoCbnpewHBlDHjPxD/tyS18x+qAhMg+g38+iZ8BhctdIzQWoXWhwwLwEdhlti6ApiGF
	3ZkGUIWn5gIBz6ahVCGfXy41WWYCQZ0n5VeoEzrpXEdmIf7NdNz0Y94P36LMQSNyqW3UC/
	I/K9a6FhHttcWtYHlijlwzEddwyYXkpa5//vMxVposYW6qQYReh/FIXXQnej6UpaVp0dYu
	WAsih+ozV5IeB9XYvEVOyP79mxw9mGFO0X0ULMlWSjvq1fyqZw3mhaXJHVsI76JwKZW1Sn
	xwqHpGm/BCmwqmxpXOqtpZcxsYU9Jdnwx6oMuyvfAOb9DN4j7BhL/LrBp5/Jwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761206455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=00Z8zJXcen6vBAxIwzWzqcCaxkxXun5gYD/COcx+fks=;
	b=30++XHrhPBp+hpoNxRrEt6tW//6dWZgqGaCwc3pX5vBPx//da9ZQU55BaKNh4FKYNI17oJ
	RFi0akzdlD2wxqAw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] perf build: Fix perf build issues with fixdep
Cc: Thorsten Leemhuis <linux@leemhuis.info>,
 Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <8881bc3321bd9fa58802e4f36286eefe3667806b.1760992391.git.jpoimboe@kernel.org>
References:
 <8881bc3321bd9fa58802e4f36286eefe3667806b.1760992391.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176120645051.2601451.8884022531775648554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f6af8690d17d8621a6c8cdb24746c904adfc9465
Gitweb:        https://git.kernel.org/tip/f6af8690d17d8621a6c8cdb24746c904adf=
c9465
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:33:15 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 23 Oct 2025 09:53:49 +02:00

perf build: Fix perf build issues with fixdep

Commit a808a2b35f66 ("tools build: Fix fixdep dependencies") broke the
perf build ("make -C tools/perf") by introducing two inadvertent
conflicts:

  1) tools/build/Makefile includes tools/build/Makefile.include, which
     defines a phony 'fixdep' target.  This conflicts with the $(FIXDEP)
     file target in tools/build/Makefile when OUTPUT is empty, causing
     make to report duplicate recipes for the same target.

  2) The FIXDEP variable in tools/build/Makefile conflicts with the
     previously existing one in tools/perf/Makefile.perf.

Remove the unnecessary include of tools/build/Makefile.include from
tools/build/Makefile, and rename the FIXDEP variable in
tools/perf/Makefile.perf to FIXDEP_BUILT.

Fixes: a808a2b35f66 ("tools build: Fix fixdep dependencies")
Reported-by: Thorsten Leemhuis <linux@leemhuis.info>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thorsten Leemhuis <linux@leemhuis.info>
Link: https://patch.msgid.link/8881bc3321bd9fa58802e4f36286eefe3667806b.17609=
92391.git.jpoimboe@kernel.org
---
 tools/build/Makefile     | 2 --
 tools/perf/Makefile.perf | 6 +++---
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/tools/build/Makefile b/tools/build/Makefile
index a5b3c29..3a5a380 100644
--- a/tools/build/Makefile
+++ b/tools/build/Makefile
@@ -37,8 +37,6 @@ ifneq ($(wildcard $(TMP_O)),)
 	$(Q)$(MAKE) -C feature OUTPUT=3D$(TMP_O) clean >/dev/null
 endif
=20
-include $(srctree)/tools/build/Makefile.include
-
 FIXDEP		:=3D $(OUTPUT)fixdep
 FIXDEP_IN	:=3D $(OUTPUT)fixdep-in.o
=20
diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 47c906b..02f87c4 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -234,12 +234,12 @@ endif
 # The fixdep build - we force fixdep tool to be built as
 # the first target in the separate make session not to be
 # disturbed by any parallel make jobs. Once fixdep is done
-# we issue the requested build with FIXDEP=3D1 variable.
+# we issue the requested build with FIXDEP_BUILT=3D1 variable.
 #
 # The fixdep build is disabled for $(NON_CONFIG_TARGETS)
 # targets, because it's not necessary.
=20
-ifdef FIXDEP
+ifdef FIXDEP_BUILT
   force_fixdep :=3D 0
 else
   force_fixdep :=3D $(config)
@@ -286,7 +286,7 @@ $(goals) all: sub-make
=20
 sub-make: fixdep
 	@./check-headers.sh
-	$(Q)$(MAKE) FIXDEP=3D1 -f Makefile.perf $(goals)
+	$(Q)$(MAKE) FIXDEP_BUILT=3D1 -f Makefile.perf $(goals)
=20
 else # force_fixdep
=20

