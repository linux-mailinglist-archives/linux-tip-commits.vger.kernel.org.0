Return-Path: <linux-tip-commits+bounces-4279-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8175DA64AB3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B40F1885F8B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:47:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E378238166;
	Mon, 17 Mar 2025 10:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yd8lyUIo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a5SSw539"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784D7236455;
	Mon, 17 Mar 2025 10:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742208394; cv=none; b=BmCYiD+PzCAN+MQpBlbvY39WP00pcEprocmP+HQnIbIHj8LoC5Zkn3cGlA22WQGJtq7rP/txNH03iSNBYNpuTvGBdQ1O5h7hcCvPYTFzkalzhcFA7eBmb7OLhF3eWjQ40oczG7INNZx7slHMFym9NHnz0ZOlA+eHSWrdJuC2tLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742208394; c=relaxed/simple;
	bh=9dpiEmiYdfgyDCxz+y8BMVOh/P3vVEeqdXWx2EwVxb4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hAADLMb7V8oLjbBpP7gWLllG6E1/stRqPlHpLnO4AwXDLSV/1iUPXyKAlcVj06iunS5OLGUfK7YPog0cUj/wtTxOqBCqGlxSvHXNzc1WkSDJydqmEu1VCedb1aD0Z9oIdF8sWBmtUfj4gr8aVI44WrOlIoBrWBr1QsEcVPuY6xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yd8lyUIo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a5SSw539; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:46:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742208390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRTRP42LJPvgE8aR+qZq4HjLWXtsr7zwqqKtWiuYU9w=;
	b=yd8lyUIoKRZUTPy2H6nLe6sIwy8Z1AmDlviVMu2pEbIT5tUlDHd3zSfz5dubkUFD9wX7bD
	+Fmi6z0Vpef7YtjTX8ejHrZHFo7M6N5II16Ha7A6cpeg26nlYVfk7dHsDqBQuCMynp/KGa
	xec49EFK7dQSqAsEbnOtOuPxp/pwuJ08RnspAEJ48BGsj8vBzaSxaN23ZVl/X8px6aHn0R
	joMYUJfu29k3CyY/5FLHD9+yG4qwbTzAZpCWipKYmzuN9ny57sKFjYJxiEQXArGrXhvOvl
	B7mbG5stYYf2ibilpOL8AKYkjOsbUC8eHVkxyqpf32XFqnqKeGYIXz2W2zcHSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742208390;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kRTRP42LJPvgE8aR+qZq4HjLWXtsr7zwqqKtWiuYU9w=;
	b=a5SSw539Awg5DSWLuL6ngcGL0WUtlfykU8m0zV1AqWAwCa+xPMaDDQ2ZxKG+5m/T1u4Te3
	qj0gNEljrn27MiDg==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: objtool/core] objtool: Increase per-function WARN_FUNC() rate limit
Cc: Josh Poimboeuf <jpoimboe@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <aec318d66c037a51c9f376d6fb0e8ff32812a037.1741975349.git.jpoimboe@kernel.org>
References:
 <aec318d66c037a51c9f376d6fb0e8ff32812a037.1741975349.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220839004.14745.13899045814377505545.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     0a7fb6f07e3ad497d31ae9a2082d2cacab43d54a
Gitweb:        https://git.kernel.org/tip/0a7fb6f07e3ad497d31ae9a2082d2cacab43d54a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Fri, 14 Mar 2025 12:29:03 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:36:00 +01:00

objtool: Increase per-function WARN_FUNC() rate limit

Increase the per-function WARN_FUNC() rate limit from 1 to 2.  If the
number of warnings for a given function goes beyond 2, print "skipping
duplicate warning(s)".  This helps root out additional warnings in a
function that might be hiding behind the first one.

Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/aec318d66c037a51c9f376d6fb0e8ff32812a037.1741975349.git.jpoimboe@kernel.org
---
 tools/objtool/check.c                |  2 +-
 tools/objtool/include/objtool/elf.h  |  2 +-
 tools/objtool/include/objtool/warn.h | 14 +++++++++++---
 3 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d6af538..2f64e46 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4547,7 +4547,7 @@ static int disas_warned_funcs(struct objtool_file *file)
 	char *funcs = NULL, *tmp;
 
 	for_each_sym(file, sym) {
-		if (sym->warned) {
+		if (sym->warnings) {
 			if (!funcs) {
 				funcs = malloc(strlen(sym->name) + 1);
 				strcpy(funcs, sym->name);
diff --git a/tools/objtool/include/objtool/elf.h b/tools/objtool/include/objtool/elf.h
index d7e815c..223ac1c 100644
--- a/tools/objtool/include/objtool/elf.h
+++ b/tools/objtool/include/objtool/elf.h
@@ -65,10 +65,10 @@ struct symbol {
 	u8 return_thunk      : 1;
 	u8 fentry            : 1;
 	u8 profiling_func    : 1;
-	u8 warned	     : 1;
 	u8 embedded_insn     : 1;
 	u8 local_label       : 1;
 	u8 frame_pointer     : 1;
+	u8 warnings	     : 2;
 	struct list_head pv_target;
 	struct reloc *relocs;
 };
diff --git a/tools/objtool/include/objtool/warn.h b/tools/objtool/include/objtool/warn.h
index ac04d3f..6180288 100644
--- a/tools/objtool/include/objtool/warn.h
+++ b/tools/objtool/include/objtool/warn.h
@@ -53,14 +53,22 @@ static inline char *offstr(struct section *sec, unsigned long offset)
 	free(_str);					\
 })
 
+#define WARN_LIMIT 2
+
 #define WARN_INSN(insn, format, ...)					\
 ({									\
 	struct instruction *_insn = (insn);				\
-	if (!_insn->sym || !_insn->sym->warned)				\
+	BUILD_BUG_ON(WARN_LIMIT > 2);					\
+	if (!_insn->sym || _insn->sym->warnings < WARN_LIMIT) {		\
 		WARN_FUNC(format, _insn->sec, _insn->offset,		\
 			  ##__VA_ARGS__);				\
-	if (_insn->sym)							\
-		_insn->sym->warned = 1;					\
+		if (_insn->sym)						\
+			_insn->sym->warnings++;				\
+	} else if (_insn->sym && _insn->sym->warnings == WARN_LIMIT) {	\
+		WARN_FUNC("skipping duplicate warning(s)",		\
+			  _insn->sec, _insn->offset);			\
+		_insn->sym->warnings++;					\
+	}								\
 })
 
 #define BT_INSN(insn, format, ...)				\

