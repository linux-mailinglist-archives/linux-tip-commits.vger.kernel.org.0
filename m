Return-Path: <linux-tip-commits+bounces-7566-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ACBA9C967E8
	for <lists+linux-tip-commits@lfdr.de>; Mon, 01 Dec 2025 10:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A24984E071C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Dec 2025 09:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09053016FF;
	Mon,  1 Dec 2025 09:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b9hoa0uj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H4zJEOUt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC22E302CC9;
	Mon,  1 Dec 2025 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764582777; cv=none; b=IZepAH2G3TJ4HuyCkUE6N7oZX0fAf/ggHvq6z4YY978wFhGFF0tArtdiEmHv/JiBDJKDSACW+HFVSqmPvViOD/o2/wfQk0k89VjwQnvOWc0VJ7PZyW6ol5ImpN7R2U0K4xlmhQKWTT9WzsgV4+K2hsOhrue0r5ivvHIOFj31/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764582777; c=relaxed/simple;
	bh=fe95b12Y1A+JUgP7LlL+5E+eshwszNqUXkkAU8NkUYs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XkjZr6wcbV2MpoHVUVx61tFkRcGyYrlRpa0yhDqEMBu+6FT1qOCBj4QLPJ9QeL6BWGeE9KHzz4tBABZqgztbYP31X2JR/94tknRlQAkxGYobQGspCGXSpCCgche1ZIiWh9Er4+BCgopbiWrcxFJ5c43IhesoLkPDmYRcCV46ETI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b9hoa0uj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H4zJEOUt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 01 Dec 2025 09:52:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764582772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Yn9SYshELrhs4gJrN4fxDdSn7UYbyzBZmStQOEP5eA0=;
	b=b9hoa0ujAm48LzpogBUcvbBhna+ppZ+Bw+NNF1hroxOTTmAPRO2XxdT0LdZ1Rj2fuJJMFE
	Q+CQEqoDlsHp68xF6xBK6VHxy5SDh5oU4I02qH8mqlV1yFs/ZWlpc3nF1urP7STdeZw+7V
	Q+7Vmx3ARgokYPMtD8w9R04A97jjjOcHQyZjaMYcopLXMvOLBiTQCXdC2bNHSKZsotBd+m
	gFmwPPmfUhdJ0DZqGsDnw1VnRXi0A0RkZ6dEurGJAkYLNwWaN7Ui0UtXUoDSp5eeTyQwEb
	k4Ax5xwTONruASw1jTQ5xaJOQTORmt6Ia5U3jvQAsAFyor7hp4QTOHzX2Yb0og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764582772;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Yn9SYshELrhs4gJrN4fxDdSn7UYbyzBZmStQOEP5eA0=;
	b=H4zJEOUthkdqnDtHnMcESskRgPeAZHPs+jgqbuKvwIvfMIHQCmjv4DEnBo3T6J0GZSbHkK
	ZzV2rxR0lJpIG9DA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] objtool: Fix segfault on unknown alternatives
Cc: Alexandre Chartre <alexandre.chartre@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176458277141.498.10249599680541531664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     6ec33db1aaf06a76fb063610e668f8e12f32ebbf
Gitweb:        https://git.kernel.org/tip/6ec33db1aaf06a76fb063610e668f8e12f3=
2ebbf
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Mon, 01 Dec 2025 10:42:27 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 01 Dec 2025 10:42:27 +01:00

objtool: Fix segfault on unknown alternatives

So 'objtool --link -d vmlinux.o' gets surprised by this endbr64+endbr64 patte=
rn
in ___bpf_prog_run():

	___bpf_prog_run:
	1e7680:  ___bpf_prog_run+0x0                                                =
     push   %r12
	1e7682:  ___bpf_prog_run+0x2                                                =
     mov    %rdi,%r12
	1e7685:  ___bpf_prog_run+0x5                                                =
     push   %rbp
	1e7686:  ___bpf_prog_run+0x6                                                =
     xor    %ebp,%ebp
	1e7688:  ___bpf_prog_run+0x8                                                =
     push   %rbx
	1e7689:  ___bpf_prog_run+0x9                                                =
     mov    %rsi,%rbx
	1e768c:  ___bpf_prog_run+0xc                                                =
     movzbl (%rbx),%esi
	1e768f:  ___bpf_prog_run+0xf                                                =
     movzbl %sil,%edx
	1e7693:  ___bpf_prog_run+0x13                                               =
     mov    %esi,%eax
	1e7695:  ___bpf_prog_run+0x15                                               =
     mov    0x0(,%rdx,8),%rdx
	1e769d:  ___bpf_prog_run+0x1d                                               =
     jmp    0x1e76a2 <__x86_indirect_thunk_rdx>
	1e76a2:  ___bpf_prog_run+0x22                                               =
     endbr64
	1e76a6:  ___bpf_prog_run+0x26                                               =
     endbr64
	1e76aa:  ___bpf_prog_run+0x2a                                               =
     mov    0x4(%rbx),%edx

And crashes due to blindly dereferencing alt->insn->alt_group.

Bail out on NULL ->alt_group, which produces this warning and continues
with the disassembly, instead of a segfault:

  .git/O/vmlinux.o: warning: objtool: <alternative.1e769d>: failed to disasse=
mble alternative

Cc: Alexandre Chartre <alexandre.chartre@oracle.com>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 tools/objtool/disas.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/objtool/disas.c b/tools/objtool/disas.c
index 441b930..2b5059f 100644
--- a/tools/objtool/disas.c
+++ b/tools/objtool/disas.c
@@ -684,6 +684,9 @@ char *disas_alt_name(struct alternative *alt)
 		 *   '?'  unknown flag
 		 */
=20
+		if (!alt->insn->alt_group)
+			return NULL;
+
 		feature =3D alt->insn->alt_group->feature;
 		num =3D alt_feature(feature);
 		flags =3D alt_flags(feature);

