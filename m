Return-Path: <linux-tip-commits+bounces-6913-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 043B7BE2936
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:58:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 719D21A628EF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:59:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBB232ED25;
	Thu, 16 Oct 2025 09:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tigHHDJg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UzTK0q6B"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFF3334371;
	Thu, 16 Oct 2025 09:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608408; cv=none; b=aFvmodrksQ65GKmwkwY542oUPbqy/Qa1QDWhRb4tRdXv1HZnGOmY8nLpYYqiYdLGQIh22gtN4/PUbIHGOn5//gg2X439OouTOvlCIAg/+904O5w39EjUd7TQNAfI5rDZSnREl8L8ZLuSzXz7HOrzKzOY6Cp0pRuICdgzEx7nC7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608408; c=relaxed/simple;
	bh=902N6J/PCJJiEL92lChoUhMfz+qvwZV8Q0xdl2E2t/c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=C1uK5kpz42szWNKEpSqMWyfwcNJzoz9ZzsbILUrTANbcF/tztnEbLHXDMM3QJmmaGNbdlWCCu8+p/EMPyB8vX2z7R5Z0kMqYoyr5BbEZwRTM3KTxB2JlhafnYr3KMsoDVbED0O/un62N7Xo2Kcha/sbSrlZgvymzDVWHqhqsk4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tigHHDJg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UzTK0q6B; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:53:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0fpTdmln+7k/F81xpUhAdCtpLxyihJ01lhkYdkFbkNE=;
	b=tigHHDJgvTYRX0Py7seRfZUorQUckCPbC5LLxl1hQLME5vseaxlEbtwwFPpeffN/k8ZVas
	RW1ngVbXT3Rnb0WLEbWMoELT3URNNHrtiW2wBxMk8+vCxVACs4gZ/DJn1CC/qf7UNw1tTf
	dGpYVeyw+doTe5SydSjAVBsmIxqW2kc/lPfC8HsEoORQqN+C7sKJRbJVF09QDPTrPbS74h
	TEuWOLF9WKB7wppUVZDqixh4hUGqDdAf8fTMFbTXA5a882pOuc86W4S10lGlgqPg9qHGh1
	+84jZM4U9IICqtvDWdogZjCtYqS2NaJq69YeFwL0umg7l0z2z20l9CEi5DlL3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0fpTdmln+7k/F81xpUhAdCtpLxyihJ01lhkYdkFbkNE=;
	b=UzTK0q6BsnGxyqgqxB9CP9sx+6S5lxvl9uVQYoL0baH5f5rHmiNF1iT08BFVDwHXNKFHvd
	BOeplVudcAWo8mDg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] modpost: Ignore unresolved section bounds symbols
Cc: Masahiro Yamada <masahiroy@kernel.org>, Petr Mladek <pmladek@suse.com>,
 Joe Lawrence <joe.lawrence@redhat.com>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060838955.709179.1648660183754455287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     4109043bff31f95d3da9ace33eb3c1925fd62cbd
Gitweb:        https://git.kernel.org/tip/4109043bff31f95d3da9ace33eb3c1925fd=
62cbd
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:17 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:22 -07:00

modpost: Ignore unresolved section bounds symbols

In preparation for klp-build livepatch module creation tooling,
suppress warnings for unresolved references to linker-generated
__start_* and __stop_* section bounds symbols.

These symbols are expected to be undefined when modpost runs, as they're
created later by the linker.

Cc: Masahiro Yamada <masahiroy@kernel.org>
Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 scripts/mod/modpost.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 47c8aa2..755b842 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -606,6 +606,11 @@ static int ignore_undef_symbol(struct elf_info *info, co=
nst char *symname)
 		    strstarts(symname, "_savevr_") ||
 		    strcmp(symname, ".TOC.") =3D=3D 0)
 			return 1;
+
+	/* ignore linker-created section bounds variables */
+	if (strstarts(symname, "__start_") || strstarts(symname, "__stop_"))
+		return 1;
+
 	/* Do not ignore this symbol */
 	return 0;
 }

