Return-Path: <linux-tip-commits+bounces-6890-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D1EBE298B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 880D63B2683
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B747D32F75E;
	Thu, 16 Oct 2025 09:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QRS70Tnn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="if/xKgyl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E74531CA47;
	Thu, 16 Oct 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608382; cv=none; b=EbsAcj6zuAx/WoQTOZL9S+MdU5jxPxOalXGkgEKIRwKbuPJGSGHbz5Lc7ieAGDuN/jJnJk7XOWY2fD0AfJDAsHfFssM2FEgmUNrP/HlEsLyI7NP9hs1GNOGTz9XUPdf/xo8xJwESXIINbIHgHvXKHz7dO08CILghasOfZFYaE08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608382; c=relaxed/simple;
	bh=uKIuiN6+PLqytbUxROI9T7kJd6YtxRI0qMpjCkrS7gk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dtcjRxl+gWaOXlF2F+b3YNeBcl+IB6NsJw1cAL4+911Rm8je3dYmrnMCRRqCL0N+oxzcpZXlGDBs3h4fjTUNXUcdAV6zkYJVfQ8Ea1Rdob8bb14naFgKqNCyGIWTvNR03e7BVGzKw6LM4ae3RdV+vfmnrPZU8y/7VfBYfo88mpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QRS70Tnn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=if/xKgyl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vnJgAKWL211CuJzeMDV9IJQYGbXqGb+YRXu9W+JxGxo=;
	b=QRS70TnnacHTxswdqyJhxEqYfaXnSTDO7ndTlOPzqtgJubmBLgXREPt0bG6gmgZiS+DNU2
	IIGVP1db3MSMTGLHr81ATsF0o9qrQU88pWKZKj/aAEjY0c9LgTSkd+mk61NxvvPFHh596f
	aetYEZHMIa5xrl1CB83f5DNH/dqiMpy7Bjf6jmqdciBzgqrWcDQXeAbg/9oIyjY5BAeM3K
	QWE1xIio0jQockaUuxZ4SkrLa+yF+jBWPEmVVZ8U3u48wiX8j5o0SkpbC0HDps6/sOKivz
	+ziLNgj20VR5alDP2WEctWV/G7RbYm+exYmgIifOu3/FTLzLNh8nM31CNGMSAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608357;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=vnJgAKWL211CuJzeMDV9IJQYGbXqGb+YRXu9W+JxGxo=;
	b=if/xKgylWHY0EooRytqj2AKifUa7+MzhKtv88X6dFKRyefHCk0iRUBfBCzeiFGdN+3BuxR
	ZTIiSnrtfVCZ4mDw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Reindent check_options[]
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060835568.709179.7981628981598335600.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     935c0b6a059106c09bf5cdb70f42c1a8650843af
Gitweb:        https://git.kernel.org/tip/935c0b6a059106c09bf5cdb70f42c1a8650=
843af
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:44 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:46:48 -07:00

objtool: Reindent check_options[]

Bring the cmdline check_options[] array back into vertical alignment for
better readability.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/builtin-check.c | 54 +++++++++++++++++-----------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/tools/objtool/builtin-check.c b/tools/objtool/builtin-check.c
index 2abac92..fc91bc5 100644
--- a/tools/objtool/builtin-check.c
+++ b/tools/objtool/builtin-check.c
@@ -73,36 +73,36 @@ static int parse_hacks(const struct option *opt, const ch=
ar *str, int unset)
=20
 static const struct option check_options[] =3D {
 	OPT_GROUP("Actions:"),
+	OPT_BOOLEAN(0,		 "cfi", &opts.cfi, "annotate kernel control flow integrity =
(kCFI) function preambles"),
 	OPT_CALLBACK_OPTARG('h', "hacks", NULL, NULL, "jump_label,noinstr,skylake",=
 "patch toolchain bugs/limitations", parse_hacks),
-	OPT_BOOLEAN('i', "ibt", &opts.ibt, "validate and annotate IBT"),
-	OPT_BOOLEAN('m', "mcount", &opts.mcount, "annotate mcount/fentry calls for =
ftrace"),
-	OPT_BOOLEAN('n', "noinstr", &opts.noinstr, "validate noinstr rules"),
-	OPT_BOOLEAN(0,   "orc", &opts.orc, "generate ORC metadata"),
-	OPT_BOOLEAN('r', "retpoline", &opts.retpoline, "validate and annotate retpo=
line usage"),
-	OPT_BOOLEAN(0,   "rethunk", &opts.rethunk, "validate and annotate rethunk u=
sage"),
-	OPT_BOOLEAN(0,   "unret", &opts.unret, "validate entry unret placement"),
-	OPT_INTEGER(0,   "prefix", &opts.prefix, "generate prefix symbols"),
-	OPT_BOOLEAN('l', "sls", &opts.sls, "validate straight-line-speculation miti=
gations"),
-	OPT_BOOLEAN('s', "stackval", &opts.stackval, "validate frame pointer rules"=
),
-	OPT_BOOLEAN('t', "static-call", &opts.static_call, "annotate static calls"),
-	OPT_BOOLEAN('u', "uaccess", &opts.uaccess, "validate uaccess rules for SMAP=
"),
-	OPT_BOOLEAN(0  , "cfi", &opts.cfi, "annotate kernel control flow integrity =
(kCFI) function preambles"),
-	OPT_BOOLEAN(0  , "noabs", &opts.noabs, "reject absolute references in alloc=
atable sections"),
-	OPT_CALLBACK_OPTARG(0, "dump", NULL, NULL, "orc", "dump metadata", parse_du=
mp),
+	OPT_BOOLEAN('i',	 "ibt", &opts.ibt, "validate and annotate IBT"),
+	OPT_BOOLEAN('m',	 "mcount", &opts.mcount, "annotate mcount/fentry calls for=
 ftrace"),
+	OPT_BOOLEAN(0,		 "noabs", &opts.noabs, "reject absolute references in alloc=
atable sections"),
+	OPT_BOOLEAN('n',	 "noinstr", &opts.noinstr, "validate noinstr rules"),
+	OPT_BOOLEAN(0,		 "orc", &opts.orc, "generate ORC metadata"),
+	OPT_BOOLEAN('r',	 "retpoline", &opts.retpoline, "validate and annotate retp=
oline usage"),
+	OPT_BOOLEAN(0,		 "rethunk", &opts.rethunk, "validate and annotate rethunk u=
sage"),
+	OPT_BOOLEAN(0,		 "unret", &opts.unret, "validate entry unret placement"),
+	OPT_INTEGER(0,		 "prefix", &opts.prefix, "generate prefix symbols"),
+	OPT_BOOLEAN('l',	 "sls", &opts.sls, "validate straight-line-speculation mit=
igations"),
+	OPT_BOOLEAN('s',	 "stackval", &opts.stackval, "validate frame pointer rules=
"),
+	OPT_BOOLEAN('t',	 "static-call", &opts.static_call, "annotate static calls"=
),
+	OPT_BOOLEAN('u',	 "uaccess", &opts.uaccess, "validate uaccess rules for SMA=
P"),
+	OPT_CALLBACK_OPTARG(0,	 "dump", NULL, NULL, "orc", "dump metadata", parse_d=
ump),
=20
 	OPT_GROUP("Options:"),
-	OPT_BOOLEAN(0,   "backtrace", &opts.backtrace, "unwind on error"),
-	OPT_BOOLEAN(0,   "backup", &opts.backup, "create backup (.orig) file on war=
ning/error"),
-	OPT_BOOLEAN(0,   "dry-run", &opts.dryrun, "don't write modifications"),
-	OPT_BOOLEAN(0,   "link", &opts.link, "object is a linked object"),
-	OPT_BOOLEAN(0,   "module", &opts.module, "object is part of a kernel module=
"),
-	OPT_BOOLEAN(0,   "mnop", &opts.mnop, "nop out mcount call sites"),
-	OPT_BOOLEAN(0,   "no-unreachable", &opts.no_unreachable, "skip 'unreachable=
 instruction' warnings"),
-	OPT_STRING('o',  "output", &opts.output, "file", "output file name"),
-	OPT_BOOLEAN(0,   "sec-address", &opts.sec_address, "print section addresses=
 in warnings"),
-	OPT_BOOLEAN(0,   "stats", &opts.stats, "print statistics"),
-	OPT_BOOLEAN('v', "verbose", &opts.verbose, "verbose warnings"),
-	OPT_BOOLEAN(0,   "werror", &opts.werror, "return error on warnings"),
+	OPT_BOOLEAN(0,		 "backtrace", &opts.backtrace, "unwind on error"),
+	OPT_BOOLEAN(0,		 "backup", &opts.backup, "create backup (.orig) file on war=
ning/error"),
+	OPT_BOOLEAN(0,		 "dry-run", &opts.dryrun, "don't write modifications"),
+	OPT_BOOLEAN(0,		 "link", &opts.link, "object is a linked object"),
+	OPT_BOOLEAN(0,		 "module", &opts.module, "object is part of a kernel module=
"),
+	OPT_BOOLEAN(0,		 "mnop", &opts.mnop, "nop out mcount call sites"),
+	OPT_BOOLEAN(0,		 "no-unreachable", &opts.no_unreachable, "skip 'unreachable=
 instruction' warnings"),
+	OPT_STRING('o',		 "output", &opts.output, "file", "output file name"),
+	OPT_BOOLEAN(0,		 "sec-address", &opts.sec_address, "print section addresses=
 in warnings"),
+	OPT_BOOLEAN(0,		 "stats", &opts.stats, "print statistics"),
+	OPT_BOOLEAN('v',	 "verbose", &opts.verbose, "verbose warnings"),
+	OPT_BOOLEAN(0,		 "werror", &opts.werror, "return error on warnings"),
=20
 	OPT_END(),
 };

