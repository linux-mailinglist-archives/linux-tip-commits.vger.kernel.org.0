Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D87829AD4B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 14:29:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2900690AbgJ0N3e convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 09:29:34 -0400
Received: from mail.fireflyinternet.com ([77.68.26.236]:51846 "EHLO
        fireflyinternet.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2900685AbgJ0N3e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 09:29:34 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 22817665-1500050 
        for multiple; Tue, 27 Oct 2020 13:29:13 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201027123056.GE2651@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net> <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2> <160379817513.29534.880306651053124370@build.alporthouse.com> <20201027115955.GA2611@hirez.programming.kicks-ass.net> <20201027123056.GE2651@hirez.programming.kicks-ass.net>
Subject: Re: [tip: locking/core] lockdep: Fix usage_traceoverflow
From:   Chris Wilson <chris@chris-wilson.co.uk>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        tip-bot2 for Peter Zijlstra <tip-bot2@linutronix.de>,
        Qian Cai <cai@redhat.com>, x86 <x86@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Date:   Tue, 27 Oct 2020 13:29:10 +0000
Message-ID: <160380535006.10461.1259632375207276085@build.alporthouse.com>
User-Agent: alot/0.9
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Quoting Peter Zijlstra (2020-10-27 12:30:56)
> On Tue, Oct 27, 2020 at 12:59:55PM +0100, Peter Zijlstra wrote:
> > On Tue, Oct 27, 2020 at 11:29:35AM +0000, Chris Wilson wrote:
> > > Quoting tip-bot2 for Peter Zijlstra (2020-10-07 17:20:13)
> > > > The following commit has been merged into the locking/core branch of tip:
> > > > 
> > > > Commit-ID:     24d5a3bffef117ed90685f285c6c9d2faa3a02b4
> > > > Gitweb:        https://git.kernel.org/tip/24d5a3bffef117ed90685f285c6c9d2faa3a02b4
> > > > Author:        Peter Zijlstra <peterz@infradead.org>
> > > > AuthorDate:    Wed, 30 Sep 2020 11:49:37 +02:00
> > > > Committer:     Peter Zijlstra <peterz@infradead.org>
> > > > CommitterDate: Wed, 07 Oct 2020 18:14:17 +02:00
> > > > 
> > > > lockdep: Fix usage_traceoverflow
> > > > 
> > > > Basically print_lock_class_header()'s for loop is out of sync with the
> > > > the size of of ->usage_traces[].
> > > 
> > > We're hitting a problem,
> > > 
> > >     $ cat /proc/lockdep_stats
> > > 
> > > upon boot generates:
> > > 
> > > [   29.465702] DEBUG_LOCKS_WARN_ON(debug_atomic_read(nr_unused_locks) != nr_unused)
> > > [   29.465716] WARNING: CPU: 0 PID: 488 at kernel/locking/lockdep_proc.c:256 lockdep_stats_show+0xa33/0xac0
> > > 
> > > that bisected to this patch. Only just completed the bisection and
> > > thought you would like a heads up.
> > 
> > Oh hey, that's 'curious'... it does indeed trivially reproduce, let me
> > have a poke.
> 
> This seems to make it happy. Not quite sure that's the best solution.

Finished the first round of testing on this patch (will try the second
in a second). It solves the nr_unused_locks issue, but we find something
else:

<4> [304.908891] hm#2, depth: 6 [6], 3425cfea6ff31f7f != 547d92e9ec2ab9af
<4> [304.908897] WARNING: CPU: 0 PID: 5658 at kernel/locking/lockdep.c:3679 check_chain_key+0x1a4/0x1f0
<4> [304.908898] Modules linked in: vgem snd_hda_codec_hdmi snd_hda_codec_realtek snd_hda_codec_generic ledtrig_audio i915 mei_hdcp x86_pkg_temp_thermal coretemp crct10dif_pclmul crc32_pclmul snd_hda_intel btusb snd_intel_dspcfg btrtl snd_hda_codec btbcm btintel ghash_clmulni_intel snd_hwdep bluetooth snd_hda_core e1000e snd_pcm cdc_ether ptp usbnet mei_me mii pps_core mei ecdh_generic ecc intel_lpss_pci prime_numbers
<4> [304.908920] CPU: 0 PID: 5658 Comm: kms_psr Not tainted 5.10.0-rc1-CI-Trybot_7174+ #1
<4> [304.908922] Hardware name: Intel Corporation Ice Lake Client Platform/IceLake U DDR4 SODIMM PD RVP TLC, BIOS ICLSFWR1.R00.3183.A00.1905020411 05/02/2019
<4> [304.908923] RIP: 0010:check_chain_key+0x1a4/0x1f0
<4> [304.908925] Code: a5 d8 08 00 00 74 e7 e8 7a eb 96 00 8b b5 e0 08 00 00 4c 89 e1 89 da 4c 8b 85 d8 08 00 00 48 c7 c7 d0 8f 30 82 e8 5f 2c 92 00 <0f> 0b 5b 5d 41 5c 41 5d c3 49 89 d5 49 c7 c4 ff ff ff ff 31 db e8
<4> [304.908926] RSP: 0018:ffffc90000ba7af0 EFLAGS: 00010086
<4> [304.908928] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000002
<4> [304.908929] RDX: 0000000080000002 RSI: ffffffff82348c47 RDI: 00000000ffffffff
<4> [304.908930] RBP: ffff88812d7dc040 R08: 0000000000000000 R09: c000000100002c92
<4> [304.908931] R10: 00000000003b5380 R11: ffffc90000ba7900 R12: 3425cfea6ff31f7f
<4> [304.908931] R13: ffff88812d7dc9f0 R14: 0000000000000003 R15: ffff88812d7dc9f0
<4> [304.908933] FS:  00007f51722bb300(0000) GS:ffff88849fa00000(0000) knlGS:0000000000000000
<4> [304.908934] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
<4> [304.908935] CR2: 00007ffd197adff0 CR3: 000000011d9ee004 CR4: 0000000000770ef0
<4> [304.908935] PKRU: 55555554
<4> [304.908936] Call Trace:
<4> [304.908939]  __lock_acquire+0x5d0/0x2740
<4> [304.908941]  lock_acquire+0xdc/0x3c0
<4> [304.908944]  ? drm_modeset_lock+0xf6/0x110
<4> [304.908947]  __ww_mutex_lock.constprop.18+0xd0/0x1010
<4> [304.908949]  ? drm_modeset_lock+0xf6/0x110
<4> [304.908951]  ? drm_modeset_lock+0xf6/0x110
<4> [304.908953]  ? ww_mutex_lock_interruptible+0x39/0xa0
<4> [304.908954]  ww_mutex_lock_interruptible+0x39/0xa0
<4> [304.908956]  drm_modeset_lock+0xf6/0x110
<4> [304.908958]  drm_atomic_get_connector_state+0x28/0x180
<4> [304.909003]  intel_psr_fastset_force+0x76/0x170 [i915]
<4> [304.909034]  i915_edp_psr_debug_set+0x53/0x70 [i915]
<4> [304.909037]  simple_attr_write+0xb1/0xd0
<4> [304.909040]  full_proxy_write+0x51/0x80
<4> [304.909042]  vfs_write+0xc4/0x230
<4> [304.909043]  ksys_write+0x5a/0xd0
<4> [304.909045]  do_syscall_64+0x33/0x80
<4> [304.909046]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4> [304.909047] RIP: 0033:0x7f517180d281
<4> [304.909049] Code: c3 0f 1f 84 00 00 00 00 00 48 8b 05 59 8d 20 00 c3 0f 1f 84 00 00 00 00 00 8b 05 8a d1 20 00 85 c0 75 16 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 41 54 55 49 89 d4 53
<4> [304.909050] RSP: 002b:00007ffd197b0728 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
<4> [304.909051] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f517180d281
<4> [304.909052] RDX: 0000000000000003 RSI: 00007f5171cb0dee RDI: 0000000000000009
<4> [304.909053] RBP: 0000000000000003 R08: 00007ffd197eb1b0 R09: 000000000005d270
<4> [304.909054] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5171cb0dee
<4> [304.909055] R13: 0000000000000009 R14: 000055bad33d98c0 R15: 0000000000000000
<4> [304.909057] CPU: 0 PID: 5658 Comm: kms_psr Not tainted 5.10.0-rc1-CI-Trybot_7174+ #1
<4> [304.909058] Hardware name: Intel Corporation Ice Lake Client Platform/IceLake U DDR4 SODIMM PD RVP TLC, BIOS ICLSFWR1.R00.3183.A00.1905020411 05/02/2019
<4> [304.909059] Call Trace:
<4> [304.909061]  dump_stack+0x77/0x97
<4> [304.909064]  __warn.cold.14+0xe/0x4b
<4> [304.909066]  ? check_chain_key+0x1a4/0x1f0
<4> [304.909068]  report_bug+0xbd/0xf0
<4> [304.909070]  handle_bug+0x3f/0x70
<4> [304.909071]  exc_invalid_op+0x13/0x60
<4> [304.909072]  asm_exc_invalid_op+0x12/0x20
<4> [304.909074] RIP: 0010:check_chain_key+0x1a4/0x1f0
<4> [304.909075] Code: a5 d8 08 00 00 74 e7 e8 7a eb 96 00 8b b5 e0 08 00 00 4c 89 e1 89 da 4c 8b 85 d8 08 00 00 48 c7 c7 d0 8f 30 82 e8 5f 2c 92 00 <0f> 0b 5b 5d 41 5c 41 5d c3 49 89 d5 49 c7 c4 ff ff ff ff 31 db e8
<4> [304.909076] RSP: 0018:ffffc90000ba7af0 EFLAGS: 00010086
<4> [304.909077] RAX: 0000000000000000 RBX: 0000000000000006 RCX: 0000000000000002
<4> [304.909078] RDX: 0000000080000002 RSI: ffffffff82348c47 RDI: 00000000ffffffff
<4> [304.909079] RBP: ffff88812d7dc040 R08: 0000000000000000 R09: c000000100002c92
<4> [304.909080] R10: 00000000003b5380 R11: ffffc90000ba7900 R12: 3425cfea6ff31f7f
<4> [304.909081] R13: ffff88812d7dc9f0 R14: 0000000000000003 R15: ffff88812d7dc9f0
<4> [304.909083]  __lock_acquire+0x5d0/0x2740
<4> [304.909086]  lock_acquire+0xdc/0x3c0
<4> [304.909087]  ? drm_modeset_lock+0xf6/0x110
<4> [304.909090]  __ww_mutex_lock.constprop.18+0xd0/0x1010
<4> [304.909091]  ? drm_modeset_lock+0xf6/0x110
<4> [304.909093]  ? drm_modeset_lock+0xf6/0x110
<4> [304.909095]  ? ww_mutex_lock_interruptible+0x39/0xa0
<4> [304.909096]  ww_mutex_lock_interruptible+0x39/0xa0
<4> [304.909098]  drm_modeset_lock+0xf6/0x110
<4> [304.909100]  drm_atomic_get_connector_state+0x28/0x180
<4> [304.909149]  intel_psr_fastset_force+0x76/0x170 [i915]
<4> [304.909179]  i915_edp_psr_debug_set+0x53/0x70 [i915]
<4> [304.909181]  simple_attr_write+0xb1/0xd0
<4> [304.909183]  full_proxy_write+0x51/0x80
<4> [304.909184]  vfs_write+0xc4/0x230
<4> [304.909185]  ksys_write+0x5a/0xd0
<4> [304.909187]  do_syscall_64+0x33/0x80
<4> [304.909188]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
<4> [304.909189] RIP: 0033:0x7f517180d281
<4> [304.909190] Code: c3 0f 1f 84 00 00 00 00 00 48 8b 05 59 8d 20 00 c3 0f 1f 84 00 00 00 00 00 8b 05 8a d1 20 00 85 c0 75 16 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 57 f3 c3 0f 1f 44 00 00 41 54 55 49 89 d4 53
<4> [304.909191] RSP: 002b:00007ffd197b0728 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
<4> [304.909193] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f517180d281
<4> [304.909193] RDX: 0000000000000003 RSI: 00007f5171cb0dee RDI: 0000000000000009
<4> [304.909194] RBP: 0000000000000003 R08: 00007ffd197eb1b0 R09: 000000000005d270
<4> [304.909195] R10: 0000000000000000 R11: 0000000000000246 R12: 00007f5171cb0dee
<4> [304.909196] R13: 0000000000000009 R14: 000055bad33d98c0 R15: 0000000000000000
<4> [304.909198] irq event stamp: 93035
<4> [304.909200] hardirqs last  enabled at (93035): [<ffffffff81a8b8b2>] _raw_spin_unlock_irqrestore+0x42/0x50
<4> [304.909201] hardirqs last disabled at (93034): [<ffffffff81a8b687>] _raw_spin_lock_irqsave+0x47/0x50
<4> [304.909203] softirqs last  enabled at (92760): [<ffffffff81e00342>] __do_softirq+0x342/0x48e
<4> [304.909204] softirqs last disabled at (92753): [<ffffffff81c00f4f>] asm_call_irq_on_stack+0xf/0x20

https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7174/fi-icl-u2/igt@kms_psr@primary_mmap_gtt.html
https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7174/fi-kbl-r/igt@kms_psr@primary_page_flip.html
https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7174/fi-cml-s/igt@kms_psr@primary_mmap_gtt.html
https://intel-gfx-ci.01.org/tree/drm-tip/Trybot_7174/fi-cml-u2/igt@kms_psr@primary_page_flip.html

It is suspicious that those are all the same tests midway through the
run, so it might be our bug, but it is one we haven't seen before.
-Chris
