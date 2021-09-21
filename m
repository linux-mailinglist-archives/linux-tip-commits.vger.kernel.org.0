Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1C6412F9D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 21 Sep 2021 09:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbhIUHmy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 21 Sep 2021 03:42:54 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33544 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230334AbhIUHmv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 21 Sep 2021 03:42:51 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18L6JBpT019347;
        Tue, 21 Sep 2021 07:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=fxyxD37ZND9scnLvtlvLDgG0RHHW6SjmF9LlGk9SnWE=;
 b=f+iM57P27O0GQjdH8WOiyXq1xBDZpMBUN+hgyO2rcJt2LqyTG9GbSTbhipfG2uARCez3
 1+cz8lsZ55x3itI0Se9v3jqNwtK4gFOnRzxhlS8776F4uzC6FuodJ4sKznSjR74JlFpA
 h+KyN9zeTAkTHCuyXzr2ggZ5dGotzRbG4R/tOEo9k5HTT0gawYBt/8zRIHuRhEpes3MF
 7fI9laRssfHiNkPv6oxVLP5kqANZhe/caQ8d+MIbdDWOpFZ+jUFYPqJJmaxIC4+uDKYn
 PCdaFQFR8885A79KXn68gFwcLTkkHcs0lX1TFPNknpSFZCkzy46AaSsNqTA25bJqhnoe qA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3b757vs3cf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 07:41:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18L7elnP130947;
        Tue, 21 Sep 2021 07:41:02 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by aserp3020.oracle.com with ESMTP id 3b57x544a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Sep 2021 07:41:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQ5W/iQDAxdheoMSWBMY6vrmVqWB5K6MpQYLry0dddWSkXM9nPE5ICxYxQZ/FusIXm0eqrTsNApEbkNIqOQJEH0i0AoXckMUbqj0ApBkAgCKUHZqA+sK+5GNesIHCo1KXS+zQVQTrrzc5/Kz+n/TzUM3twqmxx1QeEIhHuAznsxaW1HWxCHJbtvICleQ9Mdf6f43yz2e74O6KbbON00kdjrKCuQFdUoNkkDvr7mgNwCSeI3AW3dcBTdM/hdlgdZkj+omWkpKB0sZ78haIBCPVpzFvkPNTRT/jWxPC8baGPCfhUR201gPyLzhfbhF7kGZ4Vc1GuUUdQ8G67tm8hipEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fxyxD37ZND9scnLvtlvLDgG0RHHW6SjmF9LlGk9SnWE=;
 b=Yiz3exUJAj/pPav5+VIn9gm8gUrV8rKPW5nxubdkYkyE7tm8ICYLJO06gNi2jlUipZUNnIdIp5iCJBVLqpP3XUw8ogewfE8m3C9FVEvQD7XgyYrruaJvwpcAZ+0ezEOB/fGSKacmrIYX9l53/zPqR/alkGvl/4Llx3QrmG60ICfqY50ORGDUR1uXtc62dhSaSXrhMpCM7aEV3XuKwCXr512FYZWMUF9rx3PBN4rdYWXCS7udFv7ouFK2cu6CnwE6MXoAfiapoY7Pqfst45UO3u8bYaa502DsWnW4/mGcaDcf2cooCwgF6ktRNyalddEP6ze4m69xIHsFIEU+fMYkOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fxyxD37ZND9scnLvtlvLDgG0RHHW6SjmF9LlGk9SnWE=;
 b=dUojm5vgTRjOEgtQNewWwG2/j1lnytmYTuMU/+UZZ9ck3CUUCx2i5/theUhFSDbpbrhgcmRE0qUzBOkD8xmisHVjhZ8dtU+3c78+AVYdwxaoujczDc+Zz4UnvvDa9N+Ecu44UQZXmCSrzwb+qCU3kBk9KMSkULOrzF+8F/AuwT0=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO6PR10MB5411.namprd10.prod.outlook.com
 (2603:10b6:5:35e::5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.16; Tue, 21 Sep
 2021 07:41:00 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4523.018; Tue, 21 Sep 2021
 07:41:00 +0000
Date:   Tue, 21 Sep 2021 10:40:42 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Yafang Shao <laoar.shao@gmail.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org
Subject: Re: [tip: sched/core] sched: Make struct sched_statistics
 independent of fair sched class
Message-ID: <20210921074042.GU2116@kadam>
References: <20210905143547.4668-3-laoar.shao@gmail.com>
 <163179357090.25758.13267982301302997472.tip-bot2@tip-bot2>
 <20210921061727.GA24828@kili>
 <YUmG8+96zgScrfqm@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YUmG8+96zgScrfqm@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0034.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Tue, 21 Sep 2021 07:40:56 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 559348b4-9c10-47ca-8990-08d97cd327be
X-MS-TrafficTypeDiagnostic: CO6PR10MB5411:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CO6PR10MB541152C5BA087A8D78D9C7338EA19@CO6PR10MB5411.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VcafffNg3t3qfXg7QmltyonLgVuJtKdjwxpDVyO35Ms2kiZz0g4IW7EEc/bazQpRVfl5ct5QDrU3wvC5nhR8QP3akmSfD910R04/ZaYuwlH1lirI2CplymMcXqOwnYMinuseE4isrRrj28a4V3/uzJ5smu8hAHjks2U+oo23DxmRC1jMKj7b62P/zRA3G/C+Sa5c+X8IK/ms4NM57NLGuZggmxwkCEbe458Nh/YCeLOcPQaYWMZgVDbjFgCRyEvhKmbvcy8i9bR64no+s1qhAFDGETCuqOBG+yPhoS6gYgdYP7kIt06HYsivoSbXWZqK3VLDBw4PbUfDf3ee5YO03cJgFkEN40y3fiuYCrU87clEDRyJqawx68S7gaIpjAgI9rHiaOitMo+R8N97GNPHCTcSLVjrF0CsPxoaaVhMkTWntYD0chAW+1t3bTvjfcciKz899OSrghluor4XQslWWCJfTZ9G19s2QyuJs228KSj13Rc/x04JJ2t8MFPIbtk/CJhZ6g3rnzqIVfpMQ9ioy9Ju0vuNjK9aY+iD+9vlL7xdzuTMEAdN81fyBfDTnOyjZkOTiLG58qLz+Kkc7Mmvvs+kwgKYyJJnrWq9ZmitSz0zmg9Maa4Eq5o3RBnirzHwprW7txKeT9fMhxKvRxb8oZktYQwmvIeZgPg2zSqaI9EmVvWcQ8Ks3mY+j6bZ3SG/pjjVVDVj2uqInSDVngr8YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(8936002)(66556008)(66946007)(316002)(86362001)(8676002)(66476007)(6496006)(52116002)(26005)(186003)(33716001)(38100700002)(38350700002)(956004)(33656002)(54906003)(6916009)(5660300002)(2906002)(83380400001)(1076003)(44832011)(4326008)(508600001)(9576002)(9686003)(55016002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Z2NNAr7x+0SmvkccWR2S9gCe76pERWcJJEVw7CR1asjFL/o6vhY+pmyidlGF?=
 =?us-ascii?Q?i9k6/lBUMP2hb3f8iQ0P/jzJ5aFBzgMEeLyIFa/jF9d8K8X75bJkjAHwMl/P?=
 =?us-ascii?Q?k0FlrgBBAFSWx4Es96IjO8x5AsdogLGL6WrmisUn4hYZGCJY8G6/ScEZUvhH?=
 =?us-ascii?Q?gNu5zqyxs0FvuNJ2vSCzF6fUo6Yyh6haPe+zD9X8oRdXUUJs9ok2hAcj5Vfh?=
 =?us-ascii?Q?zckAdmLMqYIYeUWSaRZhP/CA55EvBCGsuW31vdELVJqtTBWNPyCDCBOZi189?=
 =?us-ascii?Q?4rhetMOz1+yT+vUP6zA5HeampVs7wqzRd81EODYkfO1+H6elP9t1QZkWehUp?=
 =?us-ascii?Q?hSyQarg8F87YhtLgvd6Ayz9a1NvwvQ8KVmoFqkHcLFLH8dWg4SugQYqk1+GY?=
 =?us-ascii?Q?ynoD5Z7s4EbwEiv2hZKeM3rSHhETLjjHHDHMrQpBrbCg2HsAcTX8qlpXtDtq?=
 =?us-ascii?Q?HZjXR397Lvhq5tGnAI7DTr6Snk2o/LePICiFBuZCQ+5Ww86NW9Omv2jT7dim?=
 =?us-ascii?Q?kULgarXGQclSku2xsbVomigBZCdr8/5tJDuQ8RQXvYcLBCcDvpfA8sLUmbof?=
 =?us-ascii?Q?koGhzG1JoBJfJYv+exrsQelfB/zCxOSrF1U0J/+UkGZh6pjX2tq8wj5sQ1Xj?=
 =?us-ascii?Q?7WUvzVozB4qMWG3Q91wS+sL5NlWwWJ6XR6+RiVK94xXxAuZwlSTt7hP3BviO?=
 =?us-ascii?Q?mZscXsH4f8A1pD+L9HzfXBwmOYB+qFjgKxnrCmI9kI2QZbq4jS1Ed5ub0dBR?=
 =?us-ascii?Q?gaZ36Z7WhqnH+rOZ92gKW4PlpcAtCmGJcUefnqTvsNYSnE2lmoNrdlmgUduZ?=
 =?us-ascii?Q?f/xc+8/8ikBESb8VHtFH8/Gagw0B2RBSFuAvmjhp2cmh8U2VH0q1MZOk4lZU?=
 =?us-ascii?Q?hRo7nLLvLNU+6DVcZ4n1ruxH/VRQi+RqKIvTt9TwlBrx+FEtNeJEevgUYhEI?=
 =?us-ascii?Q?PDQaXmebm5V5BA+anbY4jXcvIkh/eubmNMV7TgHxKUf8PhEvi1zE/a11rOg8?=
 =?us-ascii?Q?0/9zZED1RywL0WxA7cEHkNO9LUJ/GhrupK/KBq+7brEqQrMNEzb0IdEz2m/V?=
 =?us-ascii?Q?C2QbfBb26xjyv5NwL1dyUppJX5uFHuuJaS9RetICL3eMc5kybChTJtbTydXs?=
 =?us-ascii?Q?ZWlFtpTb4irrZWpURoH+ayt3i3CP+YAYKNdgPFjLFcr7cMxcV7ra7vtp1Qgk?=
 =?us-ascii?Q?z+XOZcSjK5+ZiBCxFSZPG9A9MRxR7glaCU9XxWVFz4o/P55V5MpkbfpiYwaJ?=
 =?us-ascii?Q?DL4wrizQ7Z37k19htFDBzC2PaWcWSEvHKHBycOnIZFIgJsYa1i/fU1Ybcydw?=
 =?us-ascii?Q?fmOoEWc9gzOPTJ/Nyurp6blW?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 559348b4-9c10-47ca-8990-08d97cd327be
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2021 07:41:00.0685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U1UfByCmgumsZgBCVy2JLx5KCv2bksuUnkqm9+ZMYVZ0WREFfT5DyPu0oHyYfqAcAgzKNSUORJvlutekGAMdl9dcYjt7aAH872od4RGW+0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5411
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10113 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109210049
X-Proofpoint-GUID: y-_qR0sx73yV1Q4W076-NFXMCLK1cm7t
X-Proofpoint-ORIG-GUID: y-_qR0sx73yV1Q4W076-NFXMCLK1cm7t
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

On Tue, Sep 21, 2021 at 09:17:07AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 21, 2021 at 09:17:27AM +0300, Dan Carpenter wrote:
> > On Thu, Sep 16, 2021 at 11:59:30AM -0000, tip-bot2 for Yafang Shao wrote:
> > > @@ -11424,7 +11441,7 @@ int alloc_fair_sched_group(struct task_group *tg, struct task_group *parent)
> > >  		if (!cfs_rq)
> > >  			goto err;
> > >  
> > > -		se = kzalloc_node(sizeof(struct sched_entity),
> > > +		se = kzalloc_node(sizeof(struct sched_entity_stats),
> > 
> > This wasn't there in the original patch and it causes a Smatch warning
> 
> What original patch? It's part of the v4 posting.
> 
> > because "se" is declared as a "sched_entity" but it's allocating a
> > larger "sched_entity_stats" which contains a sched_entity.
> 
> Yep, on purpose.
> 
> > To me, ideally, we would update the type of se.
> 
> That's a lot of churn for very little gain. I can rewrite it like:
> 
> 	struct sched_entity_stats *ses = kzalloc_node(sizeof(*ses),...);
> 	se = &ses->se;
> 
> If that makes smatch happy. It's the exact same thing tho because we
> force ses->se to be at 0 offset.

I mean, I understood what the allocation was doing and that this was a
way to avoid churn.  But it's pretty confusing, because every "se" is
really an "ses" now right?

Anyway, just leave it.  It's fine.

regards,
dan carpenter
