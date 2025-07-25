Return-Path: <linux-tip-commits+bounces-6216-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B71B11C93
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A37F5A10DD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70402E54D0;
	Fri, 25 Jul 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YBiGAFcC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C07702E1C5D;
	Fri, 25 Jul 2025 10:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439680; cv=none; b=CO5yrPHbOxQq8BZPKgBC6gSPepmyr0Los+0dChlQBTVMdQdAFJGuV9yXAac+XUCb3LbT0Y+32Fe4paaGAbIomm5pN3FUIQUgTGmJ6xjspE6cHm97lgYzuUeQ5D8sMK2KbKA+wi+Qg8uAhZUc7d6z6obgKCXKNd3awRLSfiyUaWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439680; c=relaxed/simple;
	bh=36SuVIY83t2RuLrhsEs1ZN184iNtQ97Vt8IjdqkI70I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rh9gzs9b3ovZvBS1Zu+QIVSQ0AJLAhERMO8OKo7y1AaFrgKbembP3OFitaKMmk/KlOtaSjjdA/F/hqPly2UFcltXbZYBbFVERir/I/mFZMetV72ts8lU53w9hm8z1BfG7pSV/weEkNK3Ts2+TmfqcRXxrw05kEWSnZHZpWXaRv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YBiGAFcC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13D2DC4CEE7;
	Fri, 25 Jul 2025 10:34:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753439680;
	bh=36SuVIY83t2RuLrhsEs1ZN184iNtQ97Vt8IjdqkI70I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YBiGAFcCkGsV2rQfYxX00N7PTM0XEnLsyQKb76pevMVMF7zuk2AgKGHR9oD4Mh1pJ
	 bCSQy30sOEX2apx1bYDOAOV/PrlVIGWPfnICrZCIeOzdswqOLznGCDdIYMl9PaJUbo
	 lHmR4ivIJZnH0s6F0tROsXAMist5FlUWVcXm9+p5qaVYWwyJL2iOm8LUJjBntqXLiB
	 dUd+7jW+NG98B/WOYq8wm9ZK/wle3iHCCEGOZPQaAlqiLEzRMitIqkWxT+dXqFyAux
	 Y6P0dHIOPgZkr2RAy2d+wx3n4IESZVKWVYX9xMx+sa7sPDSr/1UnjDswt5ZI++dSNa
	 Rtxe0DCtXdHDA==
Date: Fri, 25 Jul 2025 12:34:35 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linux-tip-commits@vger.kernel.org,
	Donghoon Yu <hoony.yu@samsung.com>,
	Youngmin Nam <youngmin.nam@samsung.com>,
	John Stultz <jstultz@google.com>,
	Will McVicker <willmcvicker@google.com>, x86@kernel.org
Subject: Re: [tip: timers/clocksource] clocksource/drivers/exynos_mct: Don't
 register as a sched_clock on arm64
Message-ID: <aINdu_hrz6zJnBGb@gmail.com>
References: <20250620181719.1399856-3-willmcvicker@google.com>
 <175325504976.1420.2666973232153470630.tip-bot2@tip-bot2>
 <aIHBnFESZwjpXzjr@gmail.com>
 <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a5628c87-0dcd-4992-a59a-15550a017766@linaro.org>


* Daniel Lezcano <daniel.lezcano@linaro.org> wrote:

> On 24/07/2025 07:16, Ingo Molnar wrote:
> > 
> > * tip-bot2 for Will McVicker <tip-bot2@linutronix.de> wrote:
> > 
> > > The following commit has been merged into the timers/clocksource branch of tip:
> > > 
> > > Commit-ID:     394b981382e6198363cf513f6eb6be4c55b22e44
> > > Gitweb:        https://git.kernel.org/tip/394b981382e6198363cf513f6eb6be4c55b22e44
> > > Author:        Will McVicker <willmcvicker@google.com>
> > > AuthorDate:    Fri, 20 Jun 2025 11:17:05 -07:00
> > > Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
> > > CommitterDate: Tue, 15 Jul 2025 13:00:50 +02:00
> > > 
> > > clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64
> > > 
> > > The MCT register is unfortunately very slow to access, but importantly
> > > does not halt in the c2 idle state. So for ARM64, we can improve
> > > performance by not registering the MCT for sched_clock, allowing the
> > > system to use the faster ARM architected timer for sched_clock instead.
> > > 
> > > The MCT is still registered as a clocksource, and a clockevent in order
> > > to be a wakeup source for the arch_timer to exit the "c2" idle state.
> > > 
> > > Since ARM32 SoCs don't have an architected timer, the MCT must continue
> > > to be used for sched_clock. Detailed discussion on this topic can be
> > > found at [1].
> > > 
> > > [1] https://lore.kernel.org/linux-samsung-soc/1400188079-21832-1-git-send-email-chirantan@chromium.org/
> > > 
> > > [Original commit from https://android.googlesource.com/kernel/gs/+/630817f7080e92c5e0216095ff52f6eb8dd00727
> > > 
> > > Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
> > > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > Acked-by: John Stultz <jstultz@google.com>
> > > Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > 
> > The whole SOB chain of this commit is messy and has several serious
> > problems:
> > 
> > 1)
> > 
> > This commit has misattributed authorship: the first SOB is:
> > 
> >     Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
> > 
> > but the Author field is not Donghoon Yu:
> > 
> >     Author:        Will McVicker <willmcvicker@google.com>
> 
> Yes, you are right. I should have pay more attention to author / sob, thanks
> for spotting it.
> 
> > 2)
> > 
> > The Reviewed-by tag is misapplied:
> > 
> > > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
> > 
> > When someone passes along a patch, it's implicit that they have
> > reviewed it.
> 
> Well my understanding of the SOB chain for these is the Signed-off-by from
> Youngmin is in the delivery path because it went first to the AOSP, then
> carried on to Linux by Will. Then Reviewed-by Youngmin letting us know the
> port from AOSP to Linux is ok.
>
> > 3)
> > 
> > There's also a stray Tested-by tag by one of the SOB entries:
> > 
> > > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
> > 
> > When someone passes along a patch, it's implicit that they not only
> > have reviewed the patch, but have also tested it to a certain extent
> 
> In this specific case where the original commit is from AOSP, this chain
> seems to make sense. Souns like:
> 
> "I was in the original commit delivery path"
> "I reviewed this patch carried to Linux"
> "I tested it on Linux"

Yeah, so then this should be documented by adding a comment to the tag 
itself:

    Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
    Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
    Signed-off-by: Will McVicker <willmcvicker@google.com>
    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>   # AOSP -> Linux port
    Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com> # AOSP -> Linux port

Otherwise it's just confusing as to why there's duplicate SOB and 
Reviewed-by entries.

But as long as the porting was basically just a cherry-pick, these 
extra tags are probably superfluous. If there was a conflict resolved 
by one of the maintainers along the SOB chain, that should be marked 
explicitly, which I see was already done in some cases:

    [ dlezcano : Fixed conflict with 20250614175556.922159-2-linux@roeck-us.net ]

> > ...
> > 
> > 4)
> > 
> > Why is the 'Link' tag just in the middle of the SOB chain, instead at the end of it?
> 
> I don't know. Link must be at the end  It is stated somewhere in the
> documentation?
> 
> I use git b4 -s <msg-id> and the tool adds the Link then my sign off.

Yeah, so using tools and not looking at the end result will often just 
create a random tag order that looks messy.

On preferred tag ordering, see:

  Documentation/process/maintainer-tip.rst

  Ordering of commit tags
  ^^^^^^^^^^^^^^^^^^^^^^^
  ...

'Link' is at the end of the list of tags.

There's some logic to the -tip tag ordering (more important tags go 
before less important tags), but it's mostly just an arbitrary order 
that we try to stick to within -tip.

> > Presumably this is the proper SOB chain:
> > 
> > > Author:        Donghoon Yu <hoony.yu@samsung.com>
> > 
> > > Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
> > > Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
> > > Signed-off-by: Will McVicker <willmcvicker@google.com>
> > > Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > > Acked-by: John Stultz <jstultz@google.com>
> > > Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com
> > 
> > Correct?
> 
> 

So I got no answer for this question, but I suppose my assumption is 
correct - so I've rebased the tip:timers/clocksource commits to fix the 
misattribution and a number of other problems, and also fixed various 
typos, spelling mistakes and inconsistencies in the changelogs while at 
it. Let me know if I got something wrong.

I've attached a delta-patch of the changelog changes below - note that 
I skipped the commit IDs to make the diff easier to read.

Thanks,

	Ingo

===================>
---	2025-07-25 12:15:26.024284067 +0200
+++	2025-07-25 12:15:18.761435799 +0200
@@ -10,6 +10,7 @@ Date:   Tue Jul 15 14:18:33 2025 +0200
     the module loading.
     
     Fix this by adding the __init_or_module annotation for the functions:
+    
      - mct_init_dt()
      - mct_init_spi()
      - mct_init_dt()
@@ -17,9 +18,10 @@ Date:   Tue Jul 15 14:18:33 2025 +0200
     Compiled on ARM32 + MODULES=no, ARM64 + MODULES=yes, ARM64 +
     MODULES=no
     
-    Link: https://lore.kernel.org/r/20250715121834.2059191-1-daniel.lezcano@linaro.org
-    Reviewed-by: Will McVicker <willmcvicker@google.com>
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Reviewed-by: Will McVicker <willmcvicker@google.com>
+    Link: https://lore.kernel.org/r/20250715121834.2059191-1-daniel.lezcano@linaro.org
 
 Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
 Date:   Wed Jun 11 13:07:58 2025 +0200
@@ -30,11 +32,12 @@ Date:   Wed Jun 11 13:07:58 2025 +0200
     with MT6765.
     
     Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
-    Acked-by: Rob Herring (Arm) <robh@kernel.org>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
+    Acked-by: Rob Herring (Arm) <robh@kernel.org>
     Acked-by: Conor Dooley <conor.dooley@microchip.com>
     Link: https://lore.kernel.org/r/20250611110800.458164-2-angelogioacchino.delregno@collabora.com
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Chen Ni <nichen@iscas.ac.cn>
 Date:   Tue Jun 3 14:04:50 2025 +0800
@@ -52,9 +55,10 @@ Date:   Tue Jun 3 14:04:50 2025 +0800
     Compile tested only.
     
     Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Tested-by: Caleb James DeLisle <cjd@cjdns.fr>
     Link: https://lore.kernel.org/r/20250603060450.1310204-1-nichen@iscas.ac.cn
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Frank Li <Frank.Li@nxp.com>
 Date:   Wed May 28 12:53:50 2025 -0400
@@ -67,9 +71,10 @@ Date:   Wed May 28 12:53:50 2025 -0400
     devices, which have existed for over 15 years.
     
     Signed-off-by: Frank Li <Frank.Li@nxp.com>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Acked-by: Conor Dooley <conor.dooley@microchip.com>
     Link: https://lore.kernel.org/r/20250528165351.691848-1-Frank.Li@nxp.com
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Arnd Bergmann <arnd@arndb.de>
 Date:   Fri Jun 20 13:19:35 2025 +0200
@@ -79,19 +84,21 @@ Date:   Fri Jun 20 13:19:35 2025 +0200
     The newly added function causes a build failure on 32-bit targets with
     older compiler version such as gcc-10:
     
-    arm-linux-gnueabi-ld: drivers/clocksource/timer-tegra186.o: in function `tegra186_wdt_get_timeleft':
-    timer-tegra186.c:(.text+0x3c2): undefined reference to `__aeabi_uldivmod'
+      arm-linux-gnueabi-ld: drivers/clocksource/timer-tegra186.o: in function `tegra186_wdt_get_timeleft':
+      timer-tegra186.c:(.text+0x3c2): undefined reference to `__aeabi_uldivmod'
     
     The calculation can trivially be changed to avoid the division entirely,
     as USEC_PER_SEC is a multiple of 5. Change both such calculation for
     consistency, even though gcc apparently managed to optimize the other one
     properly already.
     
+    [ dlezcano : Fixed conflict with 20250614175556.922159-2-linux@roeck-us.net ]
+    
     Fixes: 28c842c8b0f5 ("clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELEFT support")
     Signed-off-by: Arnd Bergmann <arnd@arndb.de>
-    Link: https://lore.kernel.org/r/20250620111939.3395525-1-arnd@kernel.org
-    [dlezcano] : Fixed conflict with 20250614175556.922159-2-linux@roeck-us.net
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Link: https://lore.kernel.org/r/20250620111939.3395525-1-arnd@kernel.org
 
 Author: Guenter Roeck <linux@roeck-us.net>
 Date:   Sat Jun 14 10:55:56 2025 -0700
@@ -102,35 +109,37 @@ Date:   Sat Jun 14 10:55:56 2025 -0700
     remaining watchdog timeout. Simplify to use 32-bit operations,
     and add comments explaining why there will be no overflow.
     
-    Cc: Pohsun Su <pohsuns@nvidia.com>
-    Cc: Robert Lin <robelin@nvidia.com>
     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
+    Cc: Pohsun Su <pohsuns@nvidia.com>
+    Cc: Robert Lin <robelin@nvidia.com>
     Link: https://lore.kernel.org/r/20250614175556.922159-2-linux@roeck-us.net
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Guenter Roeck <linux@roeck-us.net>
 Date:   Sat Jun 14 10:55:55 2025 -0700
 
     clocksource/drivers/timer-tegra186: Avoid 64-bit divide operation
     
-    Building the driver on xtensa fails with
+    Building the driver on xtensa fails with:
     
-    tensa-linux-ld: drivers/clocksource/timer-tegra186.o:
+      tensa-linux-ld: drivers/clocksource/timer-tegra186.o:
             in function `tegra186_timer_remove':
-    timer-tegra186.c:(.text+0x350):
+      timer-tegra186.c:(.text+0x350):
             undefined reference to `__udivdi3'
     
     Avoid the problem by rearranging the offending code to avoid the 64-bit
     divide operation.
     
     Fixes: 28c842c8b0f5 ("clocksource/drivers/timer-tegra186: Add WDIOC_GETTIMELEFT support")
-    Cc: Pohsun Su <pohsuns@nvidia.com>
-    Cc: Robert Lin <robelin@nvidia.com>
     Signed-off-by: Guenter Roeck <linux@roeck-us.net>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
+    Cc: Pohsun Su <pohsuns@nvidia.com>
+    Cc: Robert Lin <robelin@nvidia.com>
     Link: https://lore.kernel.org/r/20250614175556.922159-1-linux@roeck-us.net
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Will McVicker <willmcvicker@google.com>
 Date:   Fri Jun 20 11:17:09 2025 -0700
@@ -143,11 +152,12 @@ Date:   Fri Jun 20 11:17:09 2025 -0700
     automatically. This allows platforms like Android to build the driver as
     a module if desired.
     
-    Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
     Signed-off-by: Will McVicker <willmcvicker@google.com>
-    Link: https://lore.kernel.org/r/20250620181719.1399856-7-willmcvicker@google.com
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
+    Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
+    Link: https://lore.kernel.org/r/20250620181719.1399856-7-willmcvicker@google.com
 
 Author: Donghoon Yu <hoony.yu@samsung.com>
 Date:   Fri Jun 20 11:17:08 2025 -0700
@@ -159,19 +169,21 @@ Date:   Fri Jun 20 11:17:08 2025 -0700
     tick timer. Once the MCT driver is loaded, it can be used as the wakeup
     source for the arch_timer.
     
+    Original commit from:
+    
+      https://android.googlesource.com/kernel/gs/+/8a52a8288ec7d88ff78f0b37480dbb0e9c65bbfd]
+    
     Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
     Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
-    [original commit from https://android.googlesource.com/kernel/gs/+/8a52a8288ec7d88ff78f0b37480dbb0e9c65bbfd]
-    Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
     Signed-off-by: Will McVicker <willmcvicker@google.com>
-    Link: https://lore.kernel.org/r/20250620181719.1399856-6-willmcvicker@google.com
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Link: https://lore.kernel.org/r/20250620181719.1399856-6-willmcvicker@google.com
 
 Author: Will McVicker <willmcvicker@google.com>
 Date:   Fri Jun 20 11:17:07 2025 -0700
 
-    clocksource/drivers/exynos_mct: Fix uninitialized irq name warning
+    clocksource/drivers/exynos_mct: Fix uninitialized IRQ name warning
     
     The Exynos MCT driver doesn't set the clocksource name until the CPU
     hotplug state is setup which happens after the IRQs are requested. This
@@ -217,32 +229,37 @@ Date:   Fri Jun 20 11:17:07 2025 -0700
     [  T430]  load_module+0x1de0/0x2500
     [  T430]  init_module_from_file+0x8c/0xdc
     
+    Signed-off-by: Will McVicker <willmcvicker@google.com>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
     Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
     Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Signed-off-by: Will McVicker <willmcvicker@google.com>
     Link: https://lore.kernel.org/r/20250620181719.1399856-5-willmcvicker@google.com
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Hosung Kim <hosung0.kim@samsung.com>
 Date:   Fri Jun 20 11:17:06 2025 -0700
 
     clocksource/drivers/exynos_mct: Set local timer interrupts as percpu
     
-    To allow the CPU to handle it's own clock events, we need to set the
+    To allow the CPU to handle its own clock events, we need to set the
     IRQF_PERCPU flag. This prevents the local timer interrupts from
     migrating to other CPUs.
     
+    Original commit from:
+    
+      https://android.googlesource.com/kernel/gs/+/03267fad19f093bac979ca78309483e9eb3a8d16
+    
     Signed-off-by: Hosung Kim <hosung0.kim@samsung.com>
-    [Original commit from https://android.googlesource.com/kernel/gs/+/03267fad19f093bac979ca78309483e9eb3a8d16]
+    Signed-off-by: Will McVicker <willmcvicker@google.com>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
     Reviewed-by: Peter Griffin <peter.griffin@linaro.org>
     Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Signed-off-by: Will McVicker <willmcvicker@google.com>
     Link: https://lore.kernel.org/r/20250620181719.1399856-4-willmcvicker@google.com
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
-Author: Will McVicker <willmcvicker@google.com>
+Author: Donghoon Yu <hoony.yu@samsung.com>
 Date:   Fri Jun 20 11:17:05 2025 -0700
 
     clocksource/drivers/exynos_mct: Don't register as a sched_clock on arm64
@@ -257,42 +274,44 @@ Date:   Fri Jun 20 11:17:05 2025 -0700
     
     Since ARM32 SoCs don't have an architected timer, the MCT must continue
     to be used for sched_clock. Detailed discussion on this topic can be
-    found at [1].
+    found at:
+    
+      https://lore.kernel.org/linux-samsung-soc/1400188079-21832-1-git-send-email-chirantan@chromium.org/
     
-    [1] https://lore.kernel.org/linux-samsung-soc/1400188079-21832-1-git-send-email-chirantan@chromium.org/
+    Original commit from:
     
-    [Original commit from https://android.googlesource.com/kernel/gs/+/630817f7080e92c5e0216095ff52f6eb8dd00727
+      https://android.googlesource.com/kernel/gs/+/630817f7080e92c5e0216095ff52f6eb8dd00727
     
     Signed-off-by: Donghoon Yu <hoony.yu@samsung.com>
     Signed-off-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Acked-by: John Stultz <jstultz@google.com>
-    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
     Signed-off-by: Will McVicker <willmcvicker@google.com>
-    Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Acked-by: John Stultz <jstultz@google.com>
+    Link: https://lore.kernel.org/r/20250620181719.1399856-3-willmcvicker@google.com
 
 Author: Will McVicker <willmcvicker@google.com>
 Date:   Fri Jun 20 11:17:04 2025 -0700
 
-    of/irq: Export of_irq_count for modules
+    of/irq: Export of_irq_count() for modules
     
-    Need to export `of_irq_count` in preparation for modularizing the Exynos
+    Need to export of_irq_count() in preparation for modularizing the Exynos
     MCT driver which uses this API for setting up the timer IRQs.
     
-    Acked-by: Rob Herring (Arm) <robh@kernel.org>
-    Acked-by: Arnd Bergmann <arnd@arndb.de>
+    Signed-off-by: Will McVicker <willmcvicker@google.com>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
     Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
     Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
-    Signed-off-by: Will McVicker <willmcvicker@google.com>
+    Acked-by: Rob Herring (Arm) <robh@kernel.org>
+    Acked-by: Arnd Bergmann <arnd@arndb.de>
     Link: https://lore.kernel.org/r/20250620181719.1399856-2-willmcvicker@google.com
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Ben Zong-You Xie <ben717@andestech.com>
 Date:   Fri Jul 11 21:30:21 2025 +0800
 
-    dt-bindings: timer: add Andes machine timer
+    dt-bindings: timer: Add Andes machine timer
     
     Add the DT binding documentation for Andes machine timer.
     
@@ -301,43 +320,47 @@ Date:   Fri Jul 11 21:30:21 2025 +0800
     the implementation of the machine timer, and it contains memory-mapped
     registers (mtime and mtimecmp). This device supports up to 32 cores.
     
-    Acked-by: Conor Dooley <conor.dooley@microchip.com>
     Signed-off-by: Ben Zong-You Xie <ben717@andestech.com>
-    Link: https://lore.kernel.org/r/20250711133025.2192404-6-ben717@andestech.com
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Acked-by: Conor Dooley <conor.dooley@microchip.com>
+    Link: https://lore.kernel.org/r/20250711133025.2192404-6-ben717@andestech.com
 
 Author: Frank Li <Frank.Li@nxp.com>
 Date:   Fri May 23 10:14:37 2025 -0400
 
-    dt-bindings: timer: fsl,ftm-timer: use items for reg
+    dt-bindings: timer: fsl,ftm-timer: Use 'items' for 'reg'
     
     The original txt binding doc is:
+    
       reg : Specifies base physical address and size of the register sets for
             the clock event device and clock source device.
     
-    And existed dts provide two reg MMIO spaces. So change to use items to
-    descript reg property.
+    And existing DTS drivers provide two 'reg' MMIO spaces. So change
+    this driver to use 'items' to describe the 'reg' property.
     
-    Update examples.
+    Update examples as well.
     
     Fixes: 8fc30d8f8e86 ("dt-bindings: timer: fsl,ftm-timer: Convert to dtschema")
-    Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
     Signed-off-by: Frank Li <Frank.Li@nxp.com>
-    Link: https://lore.kernel.org/r/20250523141437.533643-1-Frank.Li@nxp.com
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
+    Link: https://lore.kernel.org/r/20250523141437.533643-1-Frank.Li@nxp.com
 
 Author: Max Shevchenko <wctrl@proton.me>
 Date:   Wed Jul 2 13:50:40 2025 +0300
 
-    dt-bindings: timer: mediatek: add MT6572
+    dt-bindings: timer: mediatek: Add MT6572
     
     Add a compatible string for timer on the MT6572 SoC.
     
+    Signed-off-by: Max Shevchenko <wctrl@proton.me>
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
     Acked-by: Rob Herring (Arm) <robh@kernel.org>
-    Signed-off-by: Max Shevchenko <wctrl@proton.me>
     Link: https://lore.kernel.org/r/20250702-mt6572-v4-3-bde75b7ed445@proton.me
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Rob Herring (Arm) <robh@kernel.org>
 Date:   Wed Jun 11 18:26:20 2025 -0500
@@ -349,30 +372,32 @@ Date:   Wed Jun 11 18:26:20 2025 -0500
     interrupts can also be anywhere from 1 to 8. The clock-names order was
     reversed compared to what's used.
     
-    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
     Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
-    Link: https://lore.kernel.org/r/20250611232621.1508116-1-robh@kernel.org
     Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
+    Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
+    Link: https://lore.kernel.org/r/20250611232621.1508116-1-robh@kernel.org
 
 Author: Daniel Lezcano <daniel.lezcano@linaro.org>
 Date:   Mon Jun 2 17:18:51 2025 +0200
 
-    time/sched_clock: Export symbol for sched_clock register function
+    time/sched_clock: Export symbol for sched_clock_register() function
     
-    The timer drivers could be converted into modules. The different
+    Timer drivers could be converted into modules. The different
     functions to register the clocksource or the clockevent are already
-    exporting their symbols for modules but the sched_clock_register()
+    exporting their symbols for modules, but the sched_clock_register()
     function is missing.
     
-    Export the symbols so the drivers using this function can be converted
+    Export the symbol so the drivers using this function can be converted
     into modules.
     
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Will McVicker <willmcvicker@google.com>
-    Acked-by: John Stultz <jstultz@google.com>
     Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
     Reviewed-by: Carlos Llamas <cmllamas@google.com>
+    Acked-by: John Stultz <jstultz@google.com>
     Link: https://lore.kernel.org/r/20250602151853.1942521-8-daniel.lezcano@linaro.org
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Daniel Lezcano <daniel.lezcano@linaro.org>
 Date:   Mon Jun 2 17:18:50 2025 +0200
@@ -381,7 +406,7 @@ Date:   Mon Jun 2 17:18:50 2025 +0200
     
     The conversion to modules requires a correct handling of the module
     refcount in order to prevent to unload it if it is in use. That is
-    especially true with the clockevents where there is no function to
+    especially true with clockevents where there is no function to
     unregister them.
     
     The core time framework correctly handles the module refcount with the
@@ -391,9 +416,10 @@ Date:   Mon Jun 2 17:18:50 2025 +0200
     stupid things happening when the driver will be converted into a
     module.
     
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Will McVicker <willmcvicker@google.com>
     Link: https://lore.kernel.org/r/20250602151853.1942521-7-daniel.lezcano@linaro.org
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Daniel Lezcano <daniel.lezcano@linaro.org>
 Date:   Mon Jun 2 17:18:49 2025 +0200
@@ -402,7 +428,7 @@ Date:   Mon Jun 2 17:18:49 2025 +0200
     
     The conversion to modules requires a correct handling of the module
     refcount in order to prevent to unload it if it is in use. That is
-    especially true with the clockevents where there is no function to
+    especially true with clockevents where there is no function to
     unregister them.
     
     The core time framework correctly handles the module refcount with the
@@ -412,9 +438,10 @@ Date:   Mon Jun 2 17:18:49 2025 +0200
     stupid things happening when the driver will be converted into a
     module.
     
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Will McVicker <willmcvicker@google.com>
     Link: https://lore.kernel.org/r/20250602151853.1942521-6-daniel.lezcano@linaro.org
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Daniel Lezcano <daniel.lezcano@linaro.org>
 Date:   Mon Jun 2 17:18:48 2025 +0200
@@ -423,7 +450,7 @@ Date:   Mon Jun 2 17:18:48 2025 +0200
     
     The conversion to modules requires a correct handling of the module
     refcount in order to prevent to unload it if it is in use. That is
-    especially true with the clockevents where there is no function to
+    especially true with clockevents where there is no function to
     unregister them.
     
     The core time framework correctly handles the module refcount with the
@@ -433,9 +460,10 @@ Date:   Mon Jun 2 17:18:48 2025 +0200
     stupid things happening when the driver will be converted into a
     module.
     
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Will McVicker <willmcvicker@google.com>
     Link: https://lore.kernel.org/r/20250602151853.1942521-5-daniel.lezcano@linaro.org
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Daniel Lezcano <daniel.lezcano@linaro.org>
 Date:   Mon Jun 2 17:18:47 2025 +0200
@@ -444,7 +472,7 @@ Date:   Mon Jun 2 17:18:47 2025 +0200
     
     The conversion to modules requires a correct handling of the module
     refcount in order to prevent to unload it if it is in use. That is
-    especially true with the clockevents where there is no function to
+    especially true with clockevents where there is no function to
     unregister them.
     
     The core time framework correctly handles the module refcount with the
@@ -454,10 +482,11 @@ Date:   Mon Jun 2 17:18:47 2025 +0200
     stupid things happening when the driver will be converted into a
     module.
     
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Will McVicker <willmcvicker@google.com>
     Acked-by: Chen-Yu Tsai <wens@csie.org>
     Link: https://lore.kernel.org/r/20250602151853.1942521-4-daniel.lezcano@linaro.org
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Daniel Lezcano <daniel.lezcano@linaro.org>
 Date:   Mon Jun 2 17:18:46 2025 +0200
@@ -466,7 +495,7 @@ Date:   Mon Jun 2 17:18:46 2025 +0200
     
     The conversion to modules requires a correct handling of the module
     refcount in order to prevent to unload it if it is in use. That is
-    especially true with the clockevents where there is no function to
+    especially true with clockevents where there is no function to
     unregister them.
     
     The core time framework correctly handles the module refcount with the
@@ -476,9 +505,10 @@ Date:   Mon Jun 2 17:18:46 2025 +0200
     stupid things happening when the driver will be converted into a
     module.
     
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Will McVicker <willmcvicker@google.com>
     Link: https://lore.kernel.org/r/20250602151853.1942521-3-daniel.lezcano@linaro.org
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
 
 Author: Daniel Lezcano <daniel.lezcano@linaro.org>
 Date:   Mon Jun 2 17:18:45 2025 +0200
@@ -487,7 +517,7 @@ Date:   Mon Jun 2 17:18:45 2025 +0200
     
     The conversion to modules requires a correct handling of the module
     refcount in order to prevent to unload it if it is in use. That is
-    especially true with the clockevents where there is no function to
+    especially true with clockevents where there is no function to
     unregister them.
     
     The core time framework correctly handles the module refcount with the
@@ -497,6 +527,7 @@ Date:   Mon Jun 2 17:18:45 2025 +0200
     stupid things happening when the driver will be converted into a
     module.
     
+    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
+    Signed-off-by: Ingo Molnar <mingo@kernel.org>
     Reviewed-by: Will McVicker <willmcvicker@google.com>
     Link: https://lore.kernel.org/r/20250602151853.1942521-2-daniel.lezcano@linaro.org
-    Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>

