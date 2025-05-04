Return-Path: <linux-tip-commits+bounces-5208-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AABDAA8454
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 08:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F187189320C
	for <lists+linux-tip-commits@lfdr.de>; Sun,  4 May 2025 06:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AFD41A8F;
	Sun,  4 May 2025 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KWeCQB9S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488F64A29;
	Sun,  4 May 2025 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746340651; cv=none; b=GrcT41TGCoSLhVGmPQU5QysnUGuLcNs8R72hzP7ufzv8coEjbiwSm1xOAkHQgRwLvSd/xAcN1zePCNVCwtWT/ZgsDWaz58jXU4Rs9R54ieRYvajtyyQLaPlNtKkRVMcwpTu5aafq1pInE+FZAk9DSxGp5cHrHQcWeKaCN1o7bY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746340651; c=relaxed/simple;
	bh=LAaLGDDCnqM9OdvrMDXJ8ZuO0BHAmiSdlbjisjDSmmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xk1zW7q/2lU6Ut+96xjTbs+2GQGg8I4arUoTgWDCfKR//MOUe8Pddzy25sAsL7ygoN4wauX99nFzaO5vn+BLCg+kAlJ3F0riC8389tDWSXHaTvmc5IPATPDd3+nM4TEm6PtZ8fpmrRs864kRYqvtfAm+D5aHjgMVvtAplnXVFoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KWeCQB9S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C65C4CEE7;
	Sun,  4 May 2025 06:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746340650;
	bh=LAaLGDDCnqM9OdvrMDXJ8ZuO0BHAmiSdlbjisjDSmmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KWeCQB9St2AvAf+aJZboodBhKUKX50xHuR6rJgOFZAYRisIqaycdj437IN1tJyWYI
	 FFofLCF/yOkm+hYWFv0WRlFdguJw6m5UcfzqmxBYFibhuw2zfwNOxv+cEejV5s4iyG
	 9yTXQWtbQANWcB8nraYa2D3PQV9ngL20P4pHB1q/FAWVHotioIoNe0TBP9gGYv87zo
	 EhsQ2SoWyU3otrMuQCiMzm3hHQRJpDmjBteE+pXkrcykD4Z/Ync4fTY0Qhl9lXdswj
	 PXkElzbpRsEfMZy8fFrxcrwApSZMJeQInMir2j2SxdrDm72nuOX3ycKKohWXLTYKop
	 mmXK5PBQsO/YA==
Date: Sun, 4 May 2025 08:37:27 +0200
From: Ingo Molnar <mingo@kernel.org>
To: linux-kernel@vger.kernel.org
Cc: linux-tip-commits@vger.kernel.org,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org
Subject: Re: [tip: x86/platform] x86/CPU/AMD: Print the reason for the last
 reset
Message-ID: <aBcLJxjTQGa1-r5S@gmail.com>
References: <20250422234830.2840784-6-superm1@kernel.org>
 <174617858494.22196.5727323411231361285.tip-bot2@tip-bot2>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174617858494.22196.5727323411231361285.tip-bot2@tip-bot2>


* tip-bot2 for Yazen Ghannam <tip-bot2@linutronix.de> wrote:

> The register is accessed indirectly through a "PM" port in the FCH. Use
> MMIO access in order to avoid restrictions with legacy port access.
> 
> Use a late_initcall() to ensure that MMIO has been set up before trying to
> access the register.
> 
> This register was introduced with AMD Family 17h, so avoid access on older
> families. There is no CPUID feature bit for this register.
> 
>   [ bp: Simplify the reason dumping loop. ]
> 
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Co-developed-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
> Link: https://lore.kernel.org/20250422234830.2840784-6-superm1@kernel.org
> ---
>  Documentation/arch/x86/amd-debugging.rst | 42 ++++++++++++++++++-
>  arch/x86/include/asm/amd/fch.h           |  1 +-
>  arch/x86/kernel/cpu/amd.c                | 53 +++++++++++++++++++++++-
>  3 files changed, 96 insertions(+)

Looks mostly good, with a few minor comments:

> +Random reboot issues
> +====================
> +When a random reboot occurs, the high-level reason for the reboot is stored
> +in a register that will persist onto the next boot.

Please add an extra newline after the section title, as the rest of the 
document does.

> +There are 6 classes of reasons for the reboot:
> + * Software induced
> + * Power state transition
> + * Pin induced
> + * Hardware induced
> + * Remote reset
> + * Internal CPU event
>
> +.. csv-table::
> +   :header: "Bit", "Type", "Reason"
> +   :align: left
> +
> +   "0",  "Pin",      "thermal pin BP_THERMTRIP_L was tripped"
> +   "1",  "Pin",      "power button was pressed for 4 seconds"
> +   "2",  "Pin",      "shutdown pin was shorted"
> +   "4",  "Remote",   "remote ASF power off command was received"
> +   "9",  "Internal", "internal CPU thermal limit was tripped"
> +   "16", "Pin",      "system reset pin BP_SYS_RST_L was tripped"
> +   "17", "Software", "software issued PCI reset"
> +   "18", "Software", "software wrote 0x4 to reset control register 0xCF9"
> +   "19", "Software", "software wrote 0x6 to reset control register 0xCF9"
> +   "20", "Software", "software wrote 0xE to reset control register 0xCF9"
> +   "21", "Sleep",    "ACPI power state transition occurred"

This line is a bit of an odd one out: all other classes are the first 
word of their classes, while this one only says 'Sleep', that is 
specific to the event. "ACPI-state" might be a better class I suspect.

> +   "22", "Pin",      "keyboard reset pin KB_RST_L was asserted"
> +   "23", "Internal", "internal CPU shutdown event occurred"
> +   "24", "Hardware", "system failed to boot before failed boot timer expired"
> +   "25", "Hardware", "hardware watchdog timer expired"
> +   "26", "Remote",   "remote ASF reset command was received"
> +   "27", "Internal", "an uncorrected error caused a data fabric sync flood event"
> +   "29", "Internal", "FCH and MP1 failed warm reset handshake"
> +   "30", "Internal", "a parity error occurred"
> +   "31", "Internal", "a software sync flood event occurred"
> +
> +This information is read by the kernel at bootup and is saved into the
> +kernel ring buffer. When a random reboot occurs this message can be helpful
> +to determine the next component to debug such an issue.

The ring-buffer reference is a bit obtuse and confusing - printk is a 
log buffer. Maybe this refers to some earlier version of the patch?

Also:

 s/determine the next component to debug such an issue.
  /determine the next component to debug.


How about:

   This information is read by the kernel at bootup and printed into 
   the syslog. When a random reboot occurs this message can be helpful 
   to determine the next component to debug.

> +	[16] = "system reset pin BP_SYS_RST_L was tripped",

s/tripped
 /shorted

> +	[22] = "keyboard reset pin KB_RST_L was asserted",

s/asserted
 /shorted

'asserted' is fine too - but all 'pin' class messages should use 
consistent wording.

> +static __init int print_s5_reset_status_mmio(void)
> +{
> +	unsigned long value;
> +	void __iomem *addr;
> +	int i;
> +
> +	if (!cpu_feature_enabled(X86_FEATURE_ZEN))
> +		return 0;
> +
> +	addr = ioremap(FCH_PM_BASE + FCH_PM_S5_RESET_STATUS, sizeof(value));
> +	if (!addr)
> +		return 0;
> +
> +	value = ioread32(addr);
> +	iounmap(addr);
> +
> +	for (i = 0; i <= ARRAY_SIZE(s5_reset_reason_txt); i++) {
> +		if (!(value & BIT(i)))
> +			continue;
> +
> +		if (s5_reset_reason_txt[i])
> +			pr_info("x86/amd: Previous system reset reason [0x%08lx]: %s\n",
> +				value, s5_reset_reason_txt[i]);

Please use curly braces around multi-line statements.

With those addressed:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo

