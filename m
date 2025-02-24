Return-Path: <linux-tip-commits+bounces-3609-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9922EA42CEE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Feb 2025 20:45:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED9423AA7A7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 24 Feb 2025 19:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A492B2045B5;
	Mon, 24 Feb 2025 19:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oWwJSQpn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Tx/kwrv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54031F3D45;
	Mon, 24 Feb 2025 19:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426291; cv=none; b=qL1Jd1eDdvGfCGLp2ok/bMqocOxBNpV08h87rJk3eF2w6smapPInIkd2hCzdyuQv0FPsdwFKyvjYMYG14DdZZQQ6S/nvjJlmEX2JlIyfDz5RR7WWBmuqTPsiMdQos6BZke3KnM2drg7zNx/+n2Nx8iEE9EYgjWJUtWGDV3C9dfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426291; c=relaxed/simple;
	bh=9doZrFVEqg8rM/WqnKrhPuLDcKMrP907VGP4x8QZSBA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CQp0OA4kYD2aysQTWtXz+MFHZoKE5YowNZatTQ0+PekXhKOQewnm1pvcWYVrzN+46opwu3tOdOMM3ItzhF2oU87YD0VLuO8OH+xJtzsinCwgapzO/zkSlTgHCEoOhAu/JXmGaK4ikU4TDpXqf3wXPGEQa556KsXLzPBRVTtXKTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oWwJSQpn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Tx/kwrv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 24 Feb 2025 19:44:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740426287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkCaQhgnBjzfMYc4PqAZZY6fDGmDOTFNpKwKCoDSqwY=;
	b=oWwJSQpniA8qYGApEdIe/93Zb3+xPinzC/sEZq4ZSjOy3iY4hB+geyG3jKyjV0JF8dnNaO
	ypyMhd91fcgwUEvpNnVMCyhL0zMtzEcCIfeoJhuLXqaKuLiHZetjUtbbqA5D23anzv3+IS
	opbP2YRay16A6uYKm2W4zjEoASUyWHLSpwy6hlLi7US4ZYPBLj6N3DPojuBy+AdnRGbxZ/
	bNd2T88ex8uQAYHOpBmDseecNQD0s4Yvi2bS+/PecbDjXVpVG4exiGDbttQtxb7IaTPBTw
	zjtbKraeAXWKI0zOYXywnbe9V4JIPlSnqzh5QkjGpRmXAh6Tq/+PIxaDoj5/pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740426287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MkCaQhgnBjzfMYc4PqAZZY6fDGmDOTFNpKwKCoDSqwY=;
	b=9Tx/kwrvivc9r5QdgnQz5RBXZmyBUHOa/QLLOif6TenZGPR+KxBGDZmEGzjiKCpeZnszlB
	DdBADsTcik2drQDQ==
From: "tip-bot2 for Tong Tiangen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] uprobes: Reject the shared zeropage in
 uprobe_write_opcode()
Cc: Tong Tiangen <tongtiangen@huawei.com>, Ingo Molnar <mingo@kernel.org>,
 David Hildenbrand <david@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250224031149.1598949-1-tongtiangen@huawei.com>
References: <20250224031149.1598949-1-tongtiangen@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174042628408.10177.12444069940449647418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     bddf10d26e6e5114e7415a0e442ec6f51a559468
Gitweb:        https://git.kernel.org/tip/bddf10d26e6e5114e7415a0e442ec6f51a559468
Author:        Tong Tiangen <tongtiangen@huawei.com>
AuthorDate:    Mon, 24 Feb 2025 11:11:49 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 24 Feb 2025 20:37:45 +01:00

uprobes: Reject the shared zeropage in uprobe_write_opcode()

We triggered the following crash in syzkaller tests:

  BUG: Bad page state in process syz.7.38  pfn:1eff3
  page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1eff3
  flags: 0x3fffff00004004(referenced|reserved|node=0|zone=1|lastcpupid=0x1fffff)
  raw: 003fffff00004004 ffffe6c6c07bfcc8 ffffe6c6c07bfcc8 0000000000000000
  raw: 0000000000000000 0000000000000000 00000000fffffffe 0000000000000000
  page dumped because: PAGE_FLAGS_CHECK_AT_FREE flag(s) set
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
  Call Trace:
   <TASK>
   dump_stack_lvl+0x32/0x50
   bad_page+0x69/0xf0
   free_unref_page_prepare+0x401/0x500
   free_unref_page+0x6d/0x1b0
   uprobe_write_opcode+0x460/0x8e0
   install_breakpoint.part.0+0x51/0x80
   register_for_each_vma+0x1d9/0x2b0
   __uprobe_register+0x245/0x300
   bpf_uprobe_multi_link_attach+0x29b/0x4f0
   link_create+0x1e2/0x280
   __sys_bpf+0x75f/0xac0
   __x64_sys_bpf+0x1a/0x30
   do_syscall_64+0x56/0x100
   entry_SYSCALL_64_after_hwframe+0x78/0xe2

   BUG: Bad rss-counter state mm:00000000452453e0 type:MM_FILEPAGES val:-1

The following syzkaller test case can be used to reproduce:

  r2 = creat(&(0x7f0000000000)='./file0\x00', 0x8)
  write$nbd(r2, &(0x7f0000000580)=ANY=[], 0x10)
  r4 = openat(0xffffffffffffff9c, &(0x7f0000000040)='./file0\x00', 0x42, 0x0)
  mmap$IORING_OFF_SQ_RING(&(0x7f0000ffd000/0x3000)=nil, 0x3000, 0x0, 0x12, r4, 0x0)
  r5 = userfaultfd(0x80801)
  ioctl$UFFDIO_API(r5, 0xc018aa3f, &(0x7f0000000040)={0xaa, 0x20})
  r6 = userfaultfd(0x80801)
  ioctl$UFFDIO_API(r6, 0xc018aa3f, &(0x7f0000000140))
  ioctl$UFFDIO_REGISTER(r6, 0xc020aa00, &(0x7f0000000100)={{&(0x7f0000ffc000/0x4000)=nil, 0x4000}, 0x2})
  ioctl$UFFDIO_ZEROPAGE(r5, 0xc020aa04, &(0x7f0000000000)={{&(0x7f0000ffd000/0x1000)=nil, 0x1000}})
  r7 = bpf$PROG_LOAD(0x5, &(0x7f0000000140)={0x2, 0x3, &(0x7f0000000200)=ANY=[@ANYBLOB="1800000000120000000000000000000095"], &(0x7f0000000000)='GPL\x00', 0x7, 0x0, 0x0, 0x0, 0x0, '\x00', 0x0, @fallback=0x30, 0xffffffffffffffff, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x10, 0x0, @void, @value}, 0x94)
  bpf$BPF_LINK_CREATE_XDP(0x1c, &(0x7f0000000040)={r7, 0x0, 0x30, 0x1e, @val=@uprobe_multi={&(0x7f0000000080)='./file0\x00', &(0x7f0000000100)=[0x2], 0x0, 0x0, 0x1}}, 0x40)

The cause is that zero pfn is set to the PTE without increasing the RSS
count in mfill_atomic_pte_zeropage() and the refcount of zero folio does
not increase accordingly. Then, the operation on the same pfn is performed
in uprobe_write_opcode()->__replace_page() to unconditional decrease the
RSS count and old_folio's refcount.

Therefore, two bugs are introduced:

 1. The RSS count is incorrect, when process exit, the check_mm() report
    error "Bad rss-count".

 2. The reserved folio (zero folio) is freed when folio->refcount is zero,
    then free_pages_prepare->free_page_is_bad() report error
    "Bad page state".

There is more, the following warning could also theoretically be triggered:

  __replace_page()
    -> ...
      -> folio_remove_rmap_pte()
        -> VM_WARN_ON_FOLIO(is_zero_folio(folio), folio)

Considering that uprobe hit on the zero folio is a very rare case, just
reject zero old folio immediately after get_user_page_vma_remote().

[ mingo: Cleaned up the changelog ]

Fixes: 7396fa818d62 ("uprobes/core: Make background page replacement logic account for rss_stat counters")
Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Oleg Nesterov <oleg@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20250224031149.1598949-1-tongtiangen@huawei.com
---
 kernel/events/uprobes.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index bf2a87a..af53fbd 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -495,6 +495,11 @@ retry:
 	if (ret <= 0)
 		goto put_old;
 
+	if (is_zero_page(old_page)) {
+		ret = -EINVAL;
+		goto put_old;
+	}
+
 	if (WARN(!is_register && PageCompound(old_page),
 		 "uprobe unregister should never work on compound page\n")) {
 		ret = -EINVAL;

