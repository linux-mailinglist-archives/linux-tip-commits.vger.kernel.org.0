Return-Path: <linux-tip-commits+bounces-3991-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC552A4EDC3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 20:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE22D1893B29
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 19:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B4E6209F59;
	Tue,  4 Mar 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rX4/M4PL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 718381F5826;
	Tue,  4 Mar 2025 19:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741117672; cv=none; b=KiBH0yutWQdsiwASoe01Qxtv9aidfj5Xuh8qaz3Ur66i4L6U0Ab40nbrueh/7yj2Io/pyRoeiAtXjNWIIDzCC9UfmgrbSeHrjixkT3rNbJFdBz62MQI/MnMiEQl7CREIX8Twjtw8YFyFw09A5V4CJ5XZzjgE5uIDBFYrPBHJraM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741117672; c=relaxed/simple;
	bh=4St5DqIAbiz/P2oYmOp5lACJ6oS8rj1SZXkIPTZqsTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No1q6Ce6lfzyE30pMbqxZknbjSk5P0b6bbTF15+tSBnt0DhHV1wis2gs7/dWz3QpnxrMlNhlJATgAAB6DuuUMc1N0cfYYc8KuIR9/n9WiblMAwWPXqQLPVeRcj5aJrVb08sJi9BU6ZLcuVnTcL3Pl2/yNC7Rf+VcmU3ZxbkdHlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rX4/M4PL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90491C4CEE8;
	Tue,  4 Mar 2025 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741117671;
	bh=4St5DqIAbiz/P2oYmOp5lACJ6oS8rj1SZXkIPTZqsTM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rX4/M4PL+nyGTgrc5a7JjX7rR4tK/+4HRh9ZkLq4+isfw2rYU5LTKBekHIjpwchcw
	 a2SjLWIPjkbuMaTqhpJ6OqsfMp+0u5sc08EXmRgNqUJoOIyaUUzIU8xQtBGeEqont0
	 F6TjCVdynWVuplvcvfTYRrVqcqHRpXFSlLnxHT84Fd6hzxlF6gzr14og6WCmfpodRW
	 DGrx//zZf6whqL7zSbOOYMT3TYP00JJiRUOHtCAkrws2B2nVvJSPcuHXW9bXHsB8ZU
	 RcHkzqzPTdsyeReWtP6/LIKDwedOC+Jsgygg8MMusk0+JOFuvB5E+i+9X8v50r8W1D
	 dnennUuq8OZ0g==
Date: Tue, 4 Mar 2025 11:47:49 -0800
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
	linux-tip-commits@vger.kernel.org,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Brian Gerst <brgerst@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>,
	x86@kernel.org
Subject: Re: [tip: x86/asm] x86/asm: Make ASM_CALL_CONSTRAINT conditional on
 frame pointers
Message-ID: <20250304194749.zw6jdfmrctfgxfxk@jpoimboe>
References: <174099976188.10177.7153571701278544000.tip-bot2@tip-bot2>
 <CAHk-=wjSwqJhvzAT-=AY88+7QmN=U0A121cGr286ZpuNdC+yaw@mail.gmail.com>
 <Z8a66_DbMbP-V5mi@gmail.com>
 <CAHk-=wjRsMfndBGLZzkq7DOU7JOVZLsUaXnfjFvOcEw_Kd6h5g@mail.gmail.com>
 <CAHk-=wjc8jnsOkLq1YfmM0eQqceyTunLEcfpXcm1EBhCDaLLgg@mail.gmail.com>
 <20250304182132.fcn62i4ry5ndli7l@jpoimboe>
 <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wjgGD1p2bOCOeTjikNKmyDJ9zH8Fxiv5A+ts3JYacD3fA@mail.gmail.com>

On Tue, Mar 04, 2025 at 08:48:29AM -1000, Linus Torvalds wrote:
> In your own words from 8 years go in commit f5caf621ee35 ("x86/asm:
> Fix inline asm call constraints for Clang"), just having the register
> variable makes the problem go away:
> 
>     With GCC 7.2, however, GCC's behavior has changed.  It now changes its
>     behavior based on the conversion of the register variable to a global.
>     That somehow convinces it to *always* set up the frame pointer before
>     inserting *any* inline asm.  (Therefore, listing the variable as an
>     output constraint is a no-op and is no longer necessary.)
> 
> and the whole ASM_CALL_CONSTRAINT thing is just unnecessary.

I don't know if that GCC 7.2 thing from eight years ago was a fluke or
what, but without ASM_CALL_CONSTRAINT, those "call without frame pointer
save/setup" warnings are still very much active with recent compilers.

Below is what I get with empty ASM_CALL_CONSTRAINT + GCC 14 + defconfig
+ CONFIG_UNWINDER_FRAME_POINTER.

vmlinux.o: warning: objtool: .altinstr_replacement+0x569: call without frame pointer save/setup
vmlinux.o: warning: objtool: cyc2ns_read_end+0x12: call without frame pointer save/setup
vmlinux.o: warning: objtool: native_sched_clock_from_tsc+0x66: call without frame pointer save/setup
vmlinux.o: warning: objtool: kernel_fpu_end+0x26: call without frame pointer save/setup
vmlinux.o: warning: objtool: set_tls_desc+0x170: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_valid.isra.0+0x8c: call without frame pointer save/setup
vmlinux.o: warning: objtool: __ioremap_collect_map_flags+0xf4: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_modify_allowed+0x13a: call without frame pointer save/setup
vmlinux.o: warning: objtool: __virt_addr_valid+0x112: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0xd22: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0xd58: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0xd62: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0xd71: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0xd7b: call without frame pointer save/setup
vmlinux.o: warning: objtool: migrate_disable+0x57: call without frame pointer save/setup
vmlinux.o: warning: objtool: down_read_trylock+0x55: call without frame pointer save/setup
vmlinux.o: warning: objtool: down_write_trylock+0x38: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_valid+0xbb: call without frame pointer save/setup
vmlinux.o: warning: objtool: class_preempt_notrace_destructor.isra.0+0x13: call without frame pointer save/setup
vmlinux.o: warning: objtool: rcu_is_watching+0x2d: call without frame pointer save/setup
vmlinux.o: warning: objtool: __is_module_percpu_address+0xc4: call without frame pointer save/setup
vmlinux.o: warning: objtool: get_compat_sigevent+0x41: call without frame pointer save/setup
vmlinux.o: warning: objtool: kprobe_busy_end+0x1e: call without frame pointer save/setup
vmlinux.o: warning: objtool: ring_buffer_discard_commit+0x22a: call without frame pointer save/setup
vmlinux.o: warning: objtool: ring_buffer_nest_end+0x27: call without frame pointer save/setup
vmlinux.o: warning: objtool: saved_cmdlines_stop+0x19: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0x124c: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_valid+0xbb: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_valid+0xbb: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_valid+0xbb: call without frame pointer save/setup
vmlinux.o: warning: objtool: __pageblock_pfn_to_page+0x1cb: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0x1722: call without frame pointer save/setup
vmlinux.o: warning: objtool: fput+0xe6: call without frame pointer save/setup
vmlinux.o: warning: objtool: __fput_sync+0x57: call without frame pointer save/setup
vmlinux.o: warning: objtool: __getname_maybe_null+0x7: call without frame pointer save/setup
vmlinux.o: warning: objtool: __d_rehash+0x7c: call without frame pointer save/setup
vmlinux.o: warning: objtool: ___d_drop+0x84: call without frame pointer save/setup
vmlinux.o: warning: objtool: __d_lookup_unhash+0xde: call without frame pointer save/setup
vmlinux.o: warning: objtool: get_next_ino+0x3f: call without frame pointer save/setup
vmlinux.o: warning: objtool: mnt_get_write_access+0x68: call without frame pointer save/setup
vmlinux.o: warning: objtool: mnt_put_write_access+0x21: call without frame pointer save/setup
vmlinux.o: warning: objtool: mnt_put_write_access_file+0x2b: call without frame pointer save/setup
vmlinux.o: warning: objtool: mb_cache_entry_get+0x9d: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_valid+0xbb: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_valid+0xbb: call without frame pointer save/setup
vmlinux.o: warning: objtool: jbd2_journal_grab_journal_head+0x5c: call without frame pointer save/setup
vmlinux.o: warning: objtool: class_preempt_notrace_destructor.isra.0+0x13: call without frame pointer save/setup
vmlinux.o: warning: objtool: autofs_expire_multi+0xf: call without frame pointer save/setup
vmlinux.o: warning: objtool: ksys_msgsnd+0xa: call without frame pointer save/setup
vmlinux.o: warning: objtool: __x64_sys_msgsnd+0x16: call without frame pointer save/setup
vmlinux.o: warning: objtool: __ia32_sys_msgsnd+0x15: call without frame pointer save/setup
vmlinux.o: warning: objtool: compat_ksys_msgsnd+0xf: call without frame pointer save/setup
vmlinux.o: warning: objtool: __ia32_compat_sys_msgsnd+0x16: call without frame pointer save/setup
vmlinux.o: warning: objtool: __x64_sys_lsm_list_modules+0x21: call without frame pointer save/setup
vmlinux.o: warning: objtool: __ia32_sys_lsm_list_modules+0x20: call without frame pointer save/setup
vmlinux.o: warning: objtool: blk_account_io_merge_bio.part.0+0x6c: call without frame pointer save/setup
vmlinux.o: warning: objtool: blk_account_io_completion.part.0+0x5a: call without frame pointer save/setup
vmlinux.o: warning: objtool: iocg_commit_bio+0x30: call without frame pointer save/setup
vmlinux.o: warning: objtool: class_preempt_notrace_destructor.isra.0+0x13: call without frame pointer save/setup
vmlinux.o: warning: objtool: sg_miter_stop+0x6d: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0x1c6b: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0x1c82: call without frame pointer save/setup
vmlinux.o: warning: objtool: write_port+0x6f: call without frame pointer save/setup
vmlinux.o: warning: objtool: drm_clflush_page+0x67: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0x1fae: call without frame pointer save/setup
vmlinux.o: warning: objtool: check_relocations+0x62: call without frame pointer save/setup
vmlinux.o: warning: objtool: scsi_kunmap_atomic_sg+0x21: call without frame pointer save/setup
vmlinux.o: warning: objtool: serport_ldisc_compat_ioctl+0xe: call without frame pointer save/setup
vmlinux.o: warning: objtool: serport_ldisc_ioctl+0xf: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0x2286: call without frame pointer save/setup
vmlinux.o: warning: objtool: cpuidle_use_deepest_state+0x2a: call without frame pointer save/setup
vmlinux.o: warning: objtool: cpuidle_get_driver+0x20: call without frame pointer save/setup
vmlinux.o: warning: objtool: skb_abort_seq_read+0x28: call without frame pointer save/setup
vmlinux.o: warning: objtool: skb_ts_finish+0x28: call without frame pointer save/setup
vmlinux.o: warning: objtool: skb_seq_read+0x24e: call without frame pointer save/setup
vmlinux.o: warning: objtool: xdr_terminate_string+0x55: call without frame pointer save/setup
vmlinux.o: warning: objtool: class_preempt_notrace_destructor.isra.0+0x13: call without frame pointer save/setup
vmlinux.o: warning: objtool: class_preempt_notrace_destructor.isra.0+0x13: call without frame pointer save/setup
vmlinux.o: warning: objtool: find_bug+0xad: call without frame pointer save/setup
vmlinux.o: warning: objtool: generic_bug_clear_once+0x96: call without frame pointer save/setup
vmlinux.o: warning: objtool: delay_tsc+0x87: call without frame pointer save/setup
vmlinux.o: warning: objtool: .altinstr_replacement+0x5f6: call without frame pointer save/setup
vmlinux.o: warning: objtool: pfn_valid+0x81: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_spin_trylock+0x36: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_write_unlock+0x15: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_write_unlock_irq+0x16: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_write_unlock_irqrestore+0x1e: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_read_trylock+0x45: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_write_trylock+0x36: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_read_unlock+0x1b: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_read_unlock_irq+0x1c: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_read_unlock_irqrestore+0x24: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_spin_unlock+0x15: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_spin_unlock_irq+0x16: call without frame pointer save/setup
vmlinux.o: warning: objtool: _raw_spin_unlock_irqrestore+0x1e: call without frame pointer save/setup

-- 
Josh

