Return-Path: <linux-tip-commits+bounces-4601-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2767BA774FF
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 09:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5146B7A303B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Apr 2025 07:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017021E9B3A;
	Tue,  1 Apr 2025 07:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lui8OWkC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UkgApu7S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D261E9905;
	Tue,  1 Apr 2025 07:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743491722; cv=none; b=BoBO9aT+plKoLkopuUb0eYW5+izwv+DCZvme3o7Yt6mxXPW1nruOPEzowI3eptY+I5C976O0LHN/dYHKCXQFRzfJMdNrmxMPs0Vu2kGQTUhbokmes6GMBInGwCg1N/zOygt/QnHNiFdAbn5632IItQObXTdZpZA74H5ZtLqGHHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743491722; c=relaxed/simple;
	bh=1zu2a1SQEAFYNybdQBY6BrRy8Yg8RCKdK4WCo1Cpvug=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iXk76gc+dQ9jRPLO0XceT3v2jvxM52TEmyjZ0Tpq0+WiENNl+vnpHb5iu9LKE0yLTzCre4t1m5bi/rsvaUcAiK0DGFoAIKQksZkBh/mqYV/P/kjHSEK/BbQatGZ77VKO9DI3AH1HghZuNXsa8m00XzKS9n7o5u2f29woS5epZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lui8OWkC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UkgApu7S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Apr 2025 07:15:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743491719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HRpBELb4p0Ga6G7LdnIjWzakqefVmReZ/j7t3lMeZk=;
	b=Lui8OWkCktlATLdnO28l3GdaZ1nptQ69wdobLOU8jWhemmLLzAJPkvZvY2SDYlM+t73xQs
	lgSzCK3BE83dDgieKNHUeFJTL6Kj+golhNrRSXApKfu0NkeIqPaM/jvU7sos6FDQW6auBo
	3FuSBCttyuX5S1UgF3IdPjbRxNhJzvCnEGEtThfTxt4rK7kood8xgcNEBw8kQWI/1E+HqL
	uw5Z1Aj35oMlQbsgRbrj1R+ZN32/m0q/jcaYlzqxuq8Bc+upfC3XXzis3/mU9adeciAOsq
	U8Q3nJzlHxfNygb4ITxr4RPSuQn/oZtZuUT+qyKIYsMuWCiIl+ixQporDPGnBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743491719;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2HRpBELb4p0Ga6G7LdnIjWzakqefVmReZ/j7t3lMeZk=;
	b=UkgApu7SU//jN0FNX0BtQWjgIvY8XpQiNJtkQ1S2t9z5lnUxBtRjWic5PZK9e+ssY+3FA6
	6HyB5qudF0s5UjBg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Always fail on fatal errors
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <7d35684ca61eac56eb2424f300ca43c5d257b170.1743481539.git.jpoimboe@kernel.org>
References:
 <7d35684ca61eac56eb2424f300ca43c5d257b170.1743481539.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174349171881.14745.7092640846303092122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     0b10177114d1e434af850b377cf5e6620dd1d525
Gitweb:        https://git.kernel.org/tip/0b10177114d1e434af850b377cf5e6620dd1d525
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Mon, 31 Mar 2025 21:26:40 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 01 Apr 2025 09:07:13 +02:00

objtool: Always fail on fatal errors

Objtool writes several object annotations which are used to enable
critical kernel runtime functionalities like static calls and
retpoline/rethunk patching.

In the rare case where it fails to read or write an object, the
annotations don't get written, causing runtime code patching to fail and
code to become corrupted.

Due to the catastrophic nature of such warnings, convert them to errors
which fail the build regardless of CONFIG_OBJTOOL_WERROR.

Reported-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/7d35684ca61eac56eb2424f300ca43c5d257b170.1743481539.git.jpoimboe@kernel.org
Closes: https://lore.kernel.org/SJ1PR11MB61295789E25C2F5197EFF2F6B9A72@SJ1PR11MB6129.namprd11.prod.outlook.com
---
 tools/objtool/check.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c8b3c8e..cde6699 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4753,6 +4753,9 @@ out:
 	if (!ret && !warnings)
 		return 0;
 
+	if (opts.werror && warnings)
+		ret = 1;
+
 	if (opts.verbose) {
 		if (opts.werror && warnings)
 			WARN("%d warning(s) upgraded to errors", warnings);
@@ -4760,15 +4763,5 @@ out:
 		disas_warned_funcs(file);
 	}
 
-	/*
-	 * CONFIG_OBJTOOL_WERROR upgrades all warnings (and errors) to actual
-	 * errors.
-	 *
-	 * Note that even fatal errors don't yet actually return an error
-	 * without CONFIG_OBJTOOL_WERROR.  That will be fixed soon-ish.
-	 */
-	if (opts.werror)
-		return 1;
-
-	return 0;
+	return ret;
 }

