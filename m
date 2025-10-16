Return-Path: <linux-tip-commits+bounces-6893-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02113BE29A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 12:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 575753BDD8A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55D92E0B55;
	Thu, 16 Oct 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WZ1O6yLv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xxGZOW1F"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12532BF51;
	Thu, 16 Oct 2025 09:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608385; cv=none; b=q3fA74VPSjvH+/t4xhdsyKWMXX0R5gcbc7Z28d+VGxw5QicL69A2GIvCOeTgMWoTR4OmA8Vgp/VBXDFurolmS1Z4u9Txqy9oj7fbXCf6b6hfANjkxTXCANhgLkuIwQEfrHecmA5LdDmaQn59MqTkJi8yh5Q5vi3Dfz0aN6c1qcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608385; c=relaxed/simple;
	bh=23L4i+s+Jv2C68KsJqzjaKLJK23eQsGJ0BcGLU49sgM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=U3mcbtblG7xONks44Plli1xOa1CnujmnpVKD73gJn9u0VYLk6HK/9t7R16JOhvbSQQumO9cujVv4ea9V71iWxZe35KPQw5VR+Yfvjv+qIrj5I51Z1mdhQUU3NY3hdeM6l4OyffQAm9mf44tF1wnbtjJiV8BoV4wJmhfIh9OlPj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WZ1O6yLv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xxGZOW1F; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:52:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608370;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=eBXqUUZBfArwtLlXXT7UT0pURauzXrEPAobMu7fhojQ=;
	b=WZ1O6yLvUqtX7Z8Vomgt6bl1DwMkLhz0A+dKABTqjo+KKW/pyMBndPbTDkNQlG0r/Ej7fV
	ZPFxo9sm9WPRuDyvgb6k3n3V7hTkzWhk7busk1OAQJ5zAESwR+fApAWnG//5+MZyB+BBZC
	tZiSUwWiuscK0OGzkl68n/5eFjevAaBHFvA/iTjT6FFchzbtaij+VC5YL4O2ekBGJe6yiu
	e2nU5UgeaGG52CF/T3wL/LR8DEazQ7Zhh3dX0fQYopiYeaBKIinW+9po8tSEvd5gx8vB5X
	iKa9zbmBcBJ1jeF5IC+zzrJDXnKzv4hTHzVcM6djeBbiZqrjzEVlERw3O/vbjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608370;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=eBXqUUZBfArwtLlXXT7UT0pURauzXrEPAobMu7fhojQ=;
	b=xxGZOW1FOWzZjnSLOGqRzMt7zYcw2tgmmpYl9gctu4KXz3CHQUU4dyPj+S3NhLTYO3eC+L
	Q1JUEOOpK8hID9Aw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Remove .parainstructions reference
Cc: Petr Mladek <pmladek@suse.com>, Joe Lawrence <joe.lawrence@redhat.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060836873.709179.9163058243228874871.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     72e4b6b44e9f53990315c6dd9fae2b2fc89c021a
Gitweb:        https://git.kernel.org/tip/72e4b6b44e9f53990315c6dd9fae2b2fc89=
c021a
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Wed, 17 Sep 2025 09:03:34 -07:00
Committer:     Josh Poimboeuf <jpoimboe@kernel.org>
CommitterDate: Tue, 14 Oct 2025 14:45:24 -07:00

objtool: Remove .parainstructions reference

The .parainstructions section no longer exists since the following
commit:

  60bc276b129e ("x86/paravirt: Switch mixed paravirt/alternative calls to alt=
ernatives").

Remove the reference to it.

Acked-by: Petr Mladek <pmladek@suse.com>
Tested-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
---
 tools/objtool/check.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 2bd35d1..61e071c 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -4468,7 +4468,6 @@ static int validate_ibt(struct objtool_file *file)
 		    !strcmp(sec->name, ".altinstructions")		||
 		    !strcmp(sec->name, ".ibt_endbr_seal")		||
 		    !strcmp(sec->name, ".orc_unwind_ip")		||
-		    !strcmp(sec->name, ".parainstructions")		||
 		    !strcmp(sec->name, ".retpoline_sites")		||
 		    !strcmp(sec->name, ".smp_locks")			||
 		    !strcmp(sec->name, ".static_call_sites")		||

