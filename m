Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3211A2D6234
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 17:42:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392376AbgLJQlq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 11:41:46 -0500
Received: from mga07.intel.com ([134.134.136.100]:56569 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391875AbgLJQlf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 11:41:35 -0500
IronPort-SDR: X+qC+MwTTbFDHshuL30UO4hraOXO8HCTZCmlI/KpAtrp0wgBYRSorlUh5AM9T3GMlFj1RaX7Q/
 KbUzR0489QJA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="238391945"
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="238391945"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 08:40:52 -0800
IronPort-SDR: MeZNnbehwgAoigQXzsBRgezD1v3XOgJRv6yxhfySmr+Plp/T81Ze7+cECb3DsWj45PlG+Y91r0
 mtSeV4aQSDWg==
X-IronPort-AV: E=Sophos;i="5.78,408,1599548400"; 
   d="scan'208";a="364763388"
Received: from xshen14-mobl.ccr.corp.intel.com (HELO [10.254.210.172]) ([10.254.210.172])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2020 08:40:50 -0800
Subject: Re: [tip: x86/cache] x86/resctrl: Fix incorrect local bandwidth when
 mba_sc is enabled
To:     Borislav Petkov <bp@alien8.de>
Cc:     linux-tip-commits@vger.kernel.org, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Xiaochen Shen <xiaochen.shen@intel.com>
References: <1607063279-19437-1-git-send-email-xiaochen.shen@intel.com>
 <160754081861.3364.12382697409765236626.tip-bot2@tip-bot2>
 <20201209222328.GA20710@zn.tnic>
 <343e2fc7-6f64-d1b7-2ea1-cd422596f5be@intel.com>
 <20201210102625.GA26529@zn.tnic>
From:   Xiaochen Shen <xiaochen.shen@intel.com>
Message-ID: <f965241c-69c7-c021-47c9-ef0c028e8399@intel.com>
Date:   Fri, 11 Dec 2020 00:40:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201210102625.GA26529@zn.tnic>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Hi Boris,

On 12/10/2020 18:26, Borislav Petkov wrote:
> On Thu, Dec 10, 2020 at 12:45:11PM +0800, Xiaochen Shen wrote:
>> Thank you for clarifying this issue. It is not a 0-DAY CI issue.
> Which begs the question: this patch should be Cc: stable and should go
> in now, shouldn't it?
>
> Because then the first submission applies cleanly ontop of
> tip:x86/urgent.
>
> I mean, it is fixing only reporting but that reporting is kinda waaay
> off.
>
> Hmmm?
>

Yes. Thank you for pointing out this, we'd better add Cc: stable tag.
But we have to backport the patch for -stable trees because the code base
is changed by following upstream commits:

(1) For all stable trees: in commit abe8f12b4425 ("x86/resctrl: Remove
unused struct mbm_state::chunks_bw"), removing unused struct
mbm_state::chunks_bw changes the code base for this patch.

(2) For 4.14 and 4.19 stable trees: in commit fa7d949337cc ("x86/resctrl:
Rename and move rdt files to a separate directory"), the file
arch/x86/kernel/cpu/intel_rdt_monitor.c has been renamed and moved to
arch/x86/kernel/cpu/resctrl/monitor.c. This patch needs to be rebased.

I plan to do backporting for all -stable trees after this patch is merged
into upstream.

Thank you.

-- 
Best regards,
Xiaochen

